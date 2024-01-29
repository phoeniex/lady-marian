import 'package:flutter_test/flutter_test.dart';
import 'package:marian/domain/_shared/entities/paging.dart';

void main() {
  group('User', () {
    test('Should be true when current page in base zero is the same of total pages', () {
      final paging = Paging<void>(currentPage: 0, totalPages: 1);
      expect(paging.isLastPage, true);
    });

    test('Should be false when current page is the same of total pages', () {
      final paging = Paging<void>(currentPage: 3, totalPages: 3);
      expect(paging.isLastPage, false);
    });

    test('Should be false when current page in base zero is less than total pages', () {
      final paging = Paging<void>(currentPage: 2, totalPages: 5);
      expect(paging.isLastPage, false);
    });

    test('Should be false when current page in base zero is less than total pages', () {
      final paging = Paging<void>(currentPage: 2, totalPages: 0);
      expect(paging.isLastPage, false);
    });

    test('Should be false when current page in null', () {
      final paging = Paging<void>(totalPages: 0);
      expect(paging.isLastPage, false);
    });

    test('Should be false when total pages in null', () {
      final paging = Paging<void>(currentPage: 0);
      expect(paging.isLastPage, false);
    });

    test('Should be false when no data', () {
      final paging = Paging<void>();
      expect(paging.isLastPage, false);
    });
  });
}