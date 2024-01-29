import 'package:flutter/material.dart';
import 'package:marian/presentation/_shared/app_theme.dart';

class TaskEmptyList extends StatelessWidget {
  const TaskEmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 64.0),
          const Image(image: AssetImage('assets/images/im_headline_empty_task.png')),
          const SizedBox(height: 16.0),
          Text('No Task Found', style: AppTypography.titleMedium.copyWith(color: AppColor.text.main)),
          const SizedBox(height: 8.0),
          Text('You can create new Task or switch to other statuses.', textAlign: TextAlign.center, style: AppTypography.bodyMedium.copyWith(color: AppColor.text.main)),
        ],
      ),
    );
  }
}