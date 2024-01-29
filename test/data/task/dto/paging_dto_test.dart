import 'package:flutter_test/flutter_test.dart';
import 'package:marian/data/task/dto/paging_dto.dart';

void main() {
  group('PagingDto', () {
    late String referenceRawJson;
    late PagingDto referenceDto;

    test('should create object from JSON', () {
      referenceDto = PagingDto(
        currentPage: 10,
        totalPages: 20,
      );
      referenceRawJson = referenceDto.toRawJson();

      final testDto = PagingDto.fromRawJson(referenceRawJson);
      final json = testDto.toRawJson();
      expect(testDto, referenceDto);
      expect(json, referenceRawJson);
    });

    test('should create object from JSON in case of empty', () {
      referenceDto = PagingDto();
      referenceRawJson = referenceDto.toRawJson();

      final testDto = PagingDto.fromRawJson(referenceRawJson);
      final json = testDto.toRawJson();
      expect(testDto, referenceDto);
      expect(json, referenceRawJson);
    });
  });
}