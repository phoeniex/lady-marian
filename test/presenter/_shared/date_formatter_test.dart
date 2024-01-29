import 'package:flutter_test/flutter_test.dart';
import 'package:marian/presentation/_shared/date_formatter.dart';

void main() {
  group('RelationalDateFormatter', () {
    test('should return word today if date is today', () {
      final date = DateTime.now();
      expect(RelationalDateFormatter.formatInDay(date), 'Today');
    });

    test('should return word yesterday if date is yesterday', () {
      final date = DateTime.now().subtract(const Duration(days:1));
      expect(RelationalDateFormatter.formatInDay(date), 'Yesterday');
    });

    test('should return word tomorrow if date is tomorrow', () {
      final date = DateTime.now().add(const Duration(days:1));
      expect(RelationalDateFormatter.formatInDay(date), 'Tomorrow');
    });

    test('should return empty if date is null', () {
      expect(RelationalDateFormatter.formatInDay(null), '');
    });

    test('should return word sunday if date is in sunday', () {
      final date = DateTime.parse('2024-01-21T12:00:00Z');
      expect(RelationalDateFormatter.formatInDay(date), 'Sunday');
    });
  });
}