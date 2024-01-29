import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marian/domain/auth/repositories/auth_repository.dart';
import 'package:marian/domain/task/repositories/task_repository.dart';
import 'package:mockingjay/mockingjay.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
    TaskRepository? taskRepository,
    AuthRepository? authRepository,
  }) {
    final innerChild = Scaffold(body: widget);

    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: taskRepository ?? MockTaskRepository()),
          RepositoryProvider.value(value: authRepository ?? MockAuthRepository()),
        ],
        child: MaterialApp(
          home: navigator == null
              ? innerChild
              : MockNavigatorProvider(
                  navigator: navigator,
                  child: innerChild,
                ),
        ),
      ),
    );
  }
}
