import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marian/domain/task/entities/task.dart';
import 'package:marian/presentation/_shared/app_theme.dart';

typedef OnTaskDeleted = void Function(String? id);

class TaskCardContent extends StatelessWidget {
  final Task? task;
  final OnTaskDeleted? onTaskDeleted;

  const TaskCardContent({
    super.key,
    required this.task,
    required this.onTaskDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(UniqueKey().toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) { onTaskDeleted?.call(task?.id); },
      background: Container(
        decoration: BoxDecoration(color: AppColor.surface.dismissal, borderRadius: BorderRadius.circular(8)),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SvgPicture.asset('assets/icons/ic_delete.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(AppColor.icon.dismissal, BlendMode.srcIn),
            ),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(color: AppColor.surface.card, borderRadius: BorderRadius.circular(8), boxShadow: [AppShadow.normalNeutral]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(task?.title ?? '', style: AppTypography.titleMedium.copyWith(color: AppColor.text.main)),
              const SizedBox(height: 8.0),
              Text(task?.description ?? '', style: AppTypography.bodyMedium.copyWith(color: AppColor.text.main)),
            ],
          ),
        ),
      ),
    );
  }
}
