import 'package:flutter_test/flutter_test.dart';
import 'package:marian/domain/task/entities/task.dart';

void main() {
  group('TaskStatus', () {
    test('should convert todo status from api', () {
      final status = TaskStatus.fromApiString('TODO');
      expect(status, TaskStatus.toDo);
    });

    test('should convert doing status from api', () {
      final status = TaskStatus.fromApiString('DOING');
      expect(status, TaskStatus.doing);
    });

    test('should convert done status from api', () {
      final status = TaskStatus.fromApiString('DONE');
      expect(status, TaskStatus.done);
    });

    test('should convert todo lower-case string from api', () {
      final status = TaskStatus.fromApiString('todo');
      expect(status, TaskStatus.other);
    });

    test('should convert other status from api', () {
      final status = TaskStatus.fromApiString('OTHER');
      expect(status, TaskStatus.other);
    });
  });
}