import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marian/data/auth/sources/network/auth_remote.dart';
import 'package:marian/data/task/source/network/task_remote.dart';
import 'package:marian/domain/auth/repositories/auth_repository.dart';
import 'package:marian/domain/task/repositories/task_repository.dart';
import 'package:marian/presentation/pages/authen_gate.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late TaskRepository _taskRepository;
  late AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();

    _taskRepository = DefaultTaskRepository(remote: TaskApiRemoteDataSource());
    _authRepository = DefaultAuthRepository(remote: AuthApiRemoteDataSource());
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<TaskRepository>(create: (context) => _taskRepository),
          RepositoryProvider<AuthRepository>(create: (context) => _authRepository),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Rubik',
            useMaterial3: true,
          ),
          home: const AuthGatePage(),
        ));
  }
}
