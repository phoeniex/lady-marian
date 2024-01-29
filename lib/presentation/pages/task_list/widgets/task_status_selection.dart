import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:marian/domain/task/entities/task.dart';
import 'package:marian/presentation/_shared/app_theme.dart';

typedef OnTaskStatusChanged = void Function(TaskStatus status);

class TaskStatusSelection extends StatefulWidget {
  final OnTaskStatusChanged? onChanged;

  const TaskStatusSelection({super.key, required this.onChanged});

  @override
  State<TaskStatusSelection> createState() => _TaskStatusSelectionState();
}

class _TaskStatusSelectionState extends State<TaskStatusSelection> {

  void _itemTapped(TaskStatus status) {
    widget.onChanged?.call(status);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<TaskStatus>(
      initialValue: TaskStatus.toDo,
      children: const {
        TaskStatus.toDo: _SegmentedButton(title: 'To-Do'),
        TaskStatus.doing: _SegmentedButton(title: 'Doing'),
        TaskStatus.done: _SegmentedButton(title: 'Done'),
      },
      innerPadding: const EdgeInsets.all(8.0),
      fixedWidth: 80,
      decoration: BoxDecoration(
        color: AppColor.surface.tonalButton,
        borderRadius: BorderRadius.circular(40),
      ),
      thumbDecoration: BoxDecoration(
        color: AppColor.surface.elevatedButton,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppShadow.normalPrimary],
      ),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      onValueChanged: _itemTapped,
    );
  }
}

class _SegmentedButton extends StatelessWidget {
  final String title;

  const _SegmentedButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: AppTypography.captionLarge.copyWith(color: AppColor.text.tonalButton)));
  }
}
