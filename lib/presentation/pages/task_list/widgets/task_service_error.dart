import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marian/presentation/_shared/app_theme.dart';
import 'package:marian/presentation/pages/task_list/task_list_cubit.dart';

class TaskListServiceError extends StatefulWidget {
  const TaskListServiceError({super.key});

  @override
  State<StatefulWidget> createState() => _TaskListServiceErrorState();
}

class _TaskListServiceErrorState extends State<TaskListServiceError> {
  TaskListCubit get cubit => context.read<TaskListCubit>();

  @override
  Widget build(BuildContext context) {
    final taskStatus = context.select((TaskListCubit cubit) => cubit.state.taskStatus);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 64.0),
          const Image(image: AssetImage('assets/images/im_headline_service_error.png')),
          const SizedBox(height: 16.0),
          Text('Service Unavailable', style: AppTypography.titleMedium.copyWith(color: AppColor.text.main)),
          const SizedBox(height: 8.0),
          Text('This might be no connection or our service not available at the moment. Please try again.',
              textAlign: TextAlign.center, style: AppTypography.bodyMedium.copyWith(color: AppColor.text.main)),
          const SizedBox(height: 16.0),
          Container(
              width: 162,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppGradient.primary,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [AppShadow.normalPrimary],
              ),
              child: ElevatedButton.icon(
                  onPressed: ()=> cubit.updateStatus(taskStatus),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  label: Text('Retry', style: AppTypography.captionLarge.copyWith(color: AppColor.text.filledButton)),
                  icon: SvgPicture.asset(
                    'assets/icons/ic_refresh.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(AppColor.icon.filledButton, BlendMode.srcIn),
                  ))),
        ],
      ),
    );
  }
}