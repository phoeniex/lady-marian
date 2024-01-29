import 'package:equatable/equatable.dart';

enum TaskStatus {
  toDo('TODO'),
  doing('DOING'),
  done('DONE'),
  other('');

  const TaskStatus(this.apiString);
  final String apiString;

  factory TaskStatus.fromApiString(String apiString) {
    return values.firstWhere((tasks) => tasks.apiString == apiString, orElse: () => TaskStatus.other);
  }
}

class Task with EquatableMixin {
  final String id;
  final String? title;
  final String? description;
  final TaskStatus? status;
  final DateTime? created;

  Task({
    required this.id,
    this.title,
    this.description,
    this.status,
    this.created,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    status,
    created,
  ];
}