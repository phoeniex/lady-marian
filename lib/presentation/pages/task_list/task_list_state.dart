part of 'task_list_cubit.dart';

enum TaskListBehavior { initial, firstFetching, displayed, failed }

enum TaskDisplayType { header, task }

class TaskDisplayed {
  final TaskDisplayType type;
  final Task? task;
  final DateTime? date;

  factory TaskDisplayed.fromTask(Task task) {
    return TaskDisplayed(TaskDisplayType.task, task, null);
  }

  factory TaskDisplayed.fromDate(DateTime dateTime) {
    return TaskDisplayed(TaskDisplayType.header, null, dateTime);
  }

  TaskDisplayed(this.type, this.task, this.date);
}

extension TaskMapper on List<Task> {
  List<TaskDisplayed> toDisplayed() {
    final nonNullTasks = where((item) => item.created != null).toList();
    final dateGroupedTasks = groupBy(nonNullTasks, (item) => DateTime(item.created!.year, item.created!.month, item.created!.day));
    var displayedTasks = <TaskDisplayed>[];

    dateGroupedTasks.forEach((key, value) {
      displayedTasks.add(TaskDisplayed.fromDate(key));
      displayedTasks.addAll(value.map((item) => TaskDisplayed.fromTask(item)));
    });

    return displayedTasks;
  }
}

class TaskListState extends Equatable {
  final TaskListBehavior behavior;
  final List<TaskDisplayed> tasks;
  final TaskStatus taskStatus;
  final int currentPage;
  final bool isEnded;

  const TaskListState({
    this.behavior = TaskListBehavior.initial,
    this.tasks = const [],
    this.taskStatus = TaskStatus.toDo,
    this.currentPage = 0,
    this.isEnded = false,
  });

  TaskListState copyWith({
    TaskListBehavior? behavior,
    List<TaskDisplayed>? tasks,
    TaskStatus? taskStatus,
    int? currentPage,
    bool? isEnded,
  }) {
    return TaskListState(
      behavior: behavior ?? this.behavior,
      tasks: List.from(tasks ?? this.tasks, growable: false),
      taskStatus: taskStatus ?? this.taskStatus,
      currentPage: currentPage ?? this.currentPage,
      isEnded: isEnded ?? this.isEnded,
    );
  }

  @override
  List<Object> get props => [
        behavior,
        tasks.map((element) => element.type),
        taskStatus,
        currentPage,
        isEnded,
      ];
}
