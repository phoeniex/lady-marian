import 'package:equatable/equatable.dart';

class Paging<Item> with EquatableMixin {
  late List<Item>? items;
  final int? currentPage;
  final int? totalPages;

  Paging({
    this.items,
    this.currentPage,
    this.totalPages,
  });

  bool get isLastPage => (currentPage ?? 0) == (totalPages ?? 0) - 1;

  @override
  List<Object?> get props => [
    items,
    currentPage,
    totalPages,
  ];
}