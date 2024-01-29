import 'dart:convert';

import 'package:marian/domain/_shared/entities/paging.dart';

class PagingDto<Item> extends Paging<Item> {
  PagingDto({
    super.items,
    super.currentPage,
    super.totalPages,
  });

  factory PagingDto.fromRawJson(String str) => PagingDto.fromMap(json.decode(str));
  String toRawJson() => json.encode(toMap());

  factory PagingDto.fromMap(Map<String, dynamic> json) => PagingDto(
    currentPage: json['pageNumber'],
    totalPages: json['totalPages'],
  );

  Map<String, dynamic> toMap() => {
    'pageNumber': currentPage,
    'totalPages': totalPages,
  };
}