import 'dart:convert';

import 'package:marian/domain/task/entities/task.dart';

class TaskDto extends Task {
  TaskDto({
    required super.id,
    super.title,
    super.description,
    super.status,
    super.created,
  });

  factory TaskDto.fromRawJson(String str) => TaskDto.fromMap(json.decode(str));
  String toRawJson() => json.encode(toMap());

  factory TaskDto.fromMap(Map<String, dynamic> json) => TaskDto(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        status: json['status'] == null ? null : TaskStatus.fromApiString(json['status'].toString()),
        created: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status?.apiString,
        'createdAt': created?.toIso8601String(),
      };
}
