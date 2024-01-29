import 'package:flutter/material.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_card_content.dart';
import 'package:marian/presentation/pages/task_list/widgets/task_card_header.dart';
import 'package:shimmer/shimmer.dart';

class TaskLoadingList extends StatelessWidget {
  const TaskLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                TaskCardHeader(date: null),
                SizedBox(height: 8.0),
                TaskCardContent(
                  task: null,
                  onTaskDeleted: null,
                ),
                SizedBox(height: 8.0),
                TaskCardContent(
                  task: null,
                  onTaskDeleted: null,
                ),
                SizedBox(height: 8.0),
                TaskCardContent(
                  task: null,
                  onTaskDeleted: null,
                ),
              ],
            )),
      ),
    );
  }
}
