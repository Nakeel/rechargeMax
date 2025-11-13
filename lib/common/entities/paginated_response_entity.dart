import 'package:equatable/equatable.dart';
class PaginatedResponseEntity<T> extends Equatable {
  final int? pageIndex;
  final int? totalPages;
  final List<T>? result;
  final int? totalCount;
  final bool? hasPreviousPage;
  final bool? hasNextPage;

  const PaginatedResponseEntity({
    this.pageIndex,
    this.totalPages,
    this.result,
    this.totalCount,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  PaginatedResponseEntity<T> copyWith({
    int? pageIndex,
    int? totalPages,
    List<T>? result,
    int? totalCount,
    bool? hasPreviousPage,
    bool? hasNextPage,
  }) {
    return PaginatedResponseEntity<T>(
      pageIndex: pageIndex ?? this.pageIndex,
      totalPages: totalPages ?? this.totalPages,
      result: result ?? this.result,
      totalCount: totalCount ?? this.totalCount,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    pageIndex,
    totalPages,
    result,
    totalCount,
    hasPreviousPage,
    hasNextPage,
  ];
}

