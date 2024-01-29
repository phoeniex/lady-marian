import 'package:flutter/material.dart';
import 'package:marian/presentation/_shared/app_theme.dart';
import 'package:marian/presentation/_shared/date_formatter.dart';

class TaskCardHeader extends StatelessWidget {
  final DateTime? date;

  const TaskCardHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 24.0),
        Expanded(
            child: Text(
              RelationalDateFormatter.formatInDay(date),
              style: AppTypography.titleSmall.copyWith(color: AppColor.text.main),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
        ),
        Expanded(
            child: Text(
              DateFormatter.longDate.format(date ?? DateTime.now()),
              textAlign: TextAlign.end,
              style: AppTypography.captionMedium.copyWith(color: AppColor.text.description),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
