import 'package:fpdart/fpdart.dart' as fp;
import 'package:marian/data/_shared/failure.dart';
import 'package:marian/data/task/source/network/task_remote.dart';
import 'package:marian/domain/_shared/entities/paging.dart';
import 'package:marian/domain/task/entities/task.dart';

abstract class TaskRepository {
  Future<fp.Either<Failure, Paging<Task>>> getTasks({int page = 0, TaskStatus status = TaskStatus.toDo});
}

class DefaultTaskRepository implements TaskRepository {
  final TaskRemoteDataSource _remote;

  DefaultTaskRepository({required TaskRemoteDataSource remote}) : _remote = remote;

  @override
  Future<fp.Either<Failure, Paging<Task>>> getTasks({int page = 0, TaskStatus status = TaskStatus.toDo}) async {
    try {
      final fetchedList = await _remote.getTasks(page: page, status: status.apiString);
      return fp.right(fetchedList);
    } catch (error) {
      return fp.left(ApiFailure(message: error.toString()));
    }

  }
}
