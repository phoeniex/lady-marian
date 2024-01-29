import 'package:flutter_test/flutter_test.dart';
import 'package:marian/data/task/dto/task_dto.dart';
import 'package:marian/domain/task/entities/task.dart';

void main() {
  group('TaskDto', () {
    late String referenceRawJson;
    late TaskDto referenceDto;

    test('should create object from JSON', () {
      referenceDto = TaskDto(
        id: 'ID-1',
        title: 'Title Task',
        description: 'Long Task Detail',
        status: TaskStatus.doing,
        created: DateTime.parse('2024-01-01T12:00:00Z'),
      );
      referenceRawJson = referenceDto.toRawJson();

      final testDto = TaskDto.fromRawJson(referenceRawJson);
      final json = testDto.toRawJson();
      expect(testDto, referenceDto);
      expect(json, referenceRawJson);
    });

    test('should create object from JSON in case of empty', () {
      referenceDto = TaskDto(id: 'ID-2');
      referenceRawJson = referenceDto.toRawJson();

      final testDto = TaskDto.fromRawJson(referenceRawJson);
      final json = testDto.toRawJson();
      expect(testDto, referenceDto);
      expect(json, referenceRawJson);
    });
  });
}