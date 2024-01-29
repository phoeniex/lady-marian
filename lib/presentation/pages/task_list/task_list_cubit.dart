import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:marian/data/_shared/failure.dart';
import 'package:marian/domain/_shared/entities/paging.dart';
import 'package:marian/domain/task/entities/task.dart';
import 'package:marian/domain/task/repositories/task_repository.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final TaskRepository _taskRepository;

  TaskListCubit({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const TaskListState());

  Future<void> fetchTasks(int page, TaskStatus status) async {
    final result = await _taskRepository.getTasks(page: page, status: status);
    result.fold(
      (left) => _fetchFailure(left),
      (right) => _fetchSuccess(right),
    );
  }

  void updateStatus(TaskStatus status) {
    emit(state.copyWith(behavior: TaskListBehavior.firstFetching, tasks: [], currentPage: 0));
    fetchTasks(0, status);
  }

  void deleteTask(String deletedId) {
    // this is temp solution to manual remove task from display model, this should be change to getting task from api directly
    final remainingTasks = state.tasks.toList();
    remainingTasks.removeWhere((item) => item.task?.id == deletedId);

    for (int index = 0; index < remainingTasks.length; index++) {
      var task = remainingTasks[index];
      if (task.type == TaskDisplayType.header) {
        if (index + 1 < remainingTasks.length) {
          var nextTask = remainingTasks[index + 1];

          // recheck header is close to each others remove the first one
          if (nextTask.type == TaskDisplayType.header) {
            remainingTasks.removeAt(index);
          }
        } else {
          // recheck header is the last item remove it
          remainingTasks.removeAt(index);
        }
      }
    }

    emit(state.copyWith(tasks: remainingTasks));
  }

  void _fetchSuccess(Paging<Task> paging) {
    emit(
      state.copyWith(
        behavior: TaskListBehavior.displayed,
        tasks: [...state.tasks, ...paging.items?.toDisplayed() ?? []],
        currentPage: (paging.currentPage ?? 0),
        isEnded: paging.isLastPage,
      ),
    );
  }

  void _fetchFailure(Failure error) {
    emit(
      state.copyWith(
        behavior: TaskListBehavior.failed,
      ),
    );
  }
}
