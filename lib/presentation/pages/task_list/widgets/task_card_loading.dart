import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:marian/presentation/_shared/app_color.dart';

class TaskCardLoading extends StatefulWidget {
  const TaskCardLoading({super.key});

  @override
  State<TaskCardLoading> createState() => _TaskCardLoadingState();
}

class _TaskCardLoadingState extends State<TaskCardLoading> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: SvgPicture.asset('assets/icons/ic_refresh.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(AppColor.icon.loading, BlendMode.srcIn),
        ),
      ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

}