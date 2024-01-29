import 'package:flutter_test/flutter_test.dart';
import 'package:marian/domain/task/entities/task.dart';
import 'package:marian/presentation/pages/task_list/task_list_cubit.dart';

final tasksMock1 = [
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
    created: DateTime.parse('2024-01-01T13:00:00Z'),
  ),
];

final tasksMock2 = [
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
    created: DateTime.parse('2024-01-02T13:00:00Z'),
  ),
];

void main() {
  group('TaskMapper', () {
    test('should generate correct information with empty list', () {
      final testTasks = <Task>[].toDisplayed();
      expect(testTasks, []);
    });

    test('should generate correct information with single date', () {
      final testTasks = tasksMock1.toDisplayed();
      final expectedTasks = [
        TaskDisplayed(TaskDisplayType.header, null, DateTime(tasksMock1[0].created!.year, tasksMock1[0].created!.month, tasksMock1[0].created!.day)),
        TaskDisplayed(TaskDisplayType.task, tasksMock1[0], null),
        TaskDisplayed(TaskDisplayType.task, tasksMock1[1], null),
      ];
      expect(testTasks.length, equals(expectedTasks.length));
    });

    test('should generate correct information with multiple date', () {
      final testTasks = tasksMock2.toDisplayed();
      final expectedTasks = [
        TaskDisplayed(TaskDisplayType.header, null, DateTime(tasksMock2[0].created!.year, tasksMock2[0].created!.month, tasksMock2[0].created!.day)),
        TaskDisplayed(TaskDisplayType.task, tasksMock2[0], null),
        TaskDisplayed(TaskDisplayType.header, null, DateTime(tasksMock2[1].created!.year, tasksMock2[1].created!.month, tasksMock2[1].created!.day)),
        TaskDisplayed(TaskDisplayType.task, tasksMock2[1], null),
      ];
      expect(testTasks.length, equals(expectedTasks.length));
    });
  });
}