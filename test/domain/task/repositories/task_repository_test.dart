import 'package:marian/data/task/source/network/task_remote.dart';
import 'package:marian/domain/_shared/entities/paging.dart';
import 'package:marian/domain/task/entities/task.dart';
import 'package:mocktail/mocktail.dart';

class TaskMockRemoteDataSource extends Mock implements TaskRemoteDataSource {}

final pageMock = Paging<Task>(currentPage: 0, totalPages: 1, items: [
  Task(
    id: "ID-1",
    title: "First Title",
    description: "This is a long description",
    status: TaskStatus.toDo,
    created: DateTime.parse('2024-01-01T12:00:00Z'),
  ),
  Task(
    id: "ID-2",
    title: "Second Title",
    description: "This is a long description",
    status: TaskStatus.toDo,
    created: DateTime.parse('2024-01-02T12:00:00Z'),
  ),
]);

void main() {

}
