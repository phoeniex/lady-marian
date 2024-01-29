import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marian/domain/task/entities/task.dart';
import 'package:marian/domain/task/repositories/task_repository.dart';
import 'package:marian/presentation/_shared/app_theme.dart';
import 'package:marian/presentation/pages/pin_login/pin_login_page.dart';
import 'package:marian/presentation/pages/task_list/task_list_cubit.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_card_content.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_card_header.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_card_loading.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_empty.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_loading.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_service_error.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_status_selection.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  TaskListCubit get cubit => context.read<TaskListCubit>();

  @override
  void initState() {
    super.initState();

    // ensure login
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PinLoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.surface.page,
        extendBodyBehindAppBar: true,
        body: BlocProvider(
          create: (context) => TaskListCubit(taskRepository: context.read<TaskRepository>()),
          child: const _Content(),
        )
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  TaskListCubit get cubit => context.read<TaskListCubit>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Image(image: AssetImage('assets/images/im_bg_decorate_main.png')),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _Header(),
              const SizedBox(height: 32.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [TaskStatusSelection(onChanged: _updateTaskStatus)],
              ),
              const SizedBox(height: 32.0),
              const _TaskList(),
            ],
          ),
        ),
      ],
    );
  }

  _updateTaskStatus(TaskStatus status) {
    cubit.updateStatus(status);
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(31), boxShadow: [AppShadow.normalPrimary]), child: const Image(image: AssetImage('assets/images/im_avatar_default.png'))),
        const SizedBox(height: 16.0),
        Text("Hello, Lady Marian 👋", style: AppTypography.titleLarge.copyWith(color: AppColor.text.main)),
        const SizedBox(height: 16.0),
        Text("It’s a great day to you,\nYou have tasks to do. please enjoy your life.", style: AppTypography.titleSmall.copyWith(color: AppColor.text.main)),
      ],
    );
  }
}

class _TaskList extends StatefulWidget {
  const _TaskList({super.key});

  @override
  State<_TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<_TaskList> {
  TaskListCubit get cubit => context.read<TaskListCubit>();
  final PagingController<int, TaskDisplayed> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((page) {
      cubit.fetchTasks(0, TaskStatus.toDo);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskListCubit, TaskListState>(builder: (context, state) {
      if (state.behavior == TaskListBehavior.firstFetching) {
        return const TaskLoadingList();
      } else {
        return Expanded(
          child: PagedListView<int, TaskDisplayed>.separated(
              pagingController: _pagingController,
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              builderDelegate: PagedChildBuilderDelegate<TaskDisplayed>(
                itemBuilder: (context, item, index) {
                  if (item.type == TaskDisplayType.task) {
                    return TaskCardContent(task: item.task, onTaskDeleted: _onTaskDeleted);
                  } else if (item.type == TaskDisplayType.header) {
                    return TaskCardHeader(date: item.date);
                  } else {
                    return const SizedBox();
                  }
                },
                newPageProgressIndicatorBuilder: (context) => const TaskCardLoading(),
                noItemsFoundIndicatorBuilder: (context) => const TaskEmptyList(),
                firstPageProgressIndicatorBuilder: (context) => const TaskLoadingList(),
                firstPageErrorIndicatorBuilder: (context) => const TaskListServiceError(),
              )),
        );
      }
    }, listener: (context, state) {
      if (state.behavior == TaskListBehavior.displayed) {
        _pagingController.value = PagingState(nextPageKey: state.isEnded ? null : state.currentPage, itemList: state.tasks);
      } else if (state.behavior == TaskListBehavior.failed) {
        _pagingController.error = true;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _onTaskDeleted(String? deletedId) {
    if (deletedId == null) return;
    cubit.deleteTask(deletedId);
  }
}