import 'package:json_annotation/json_annotation.dart';
import 'package:recharge_max/core/_mappers/entity_convertable.dart';
import '../entities/paginated_response_entity.dart';

part 'paginated_response_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class PaginatedResponseDto<T> with EntityConvertible<PaginatedResponseDto<T>, PaginatedResponseEntity<T>> {
  final int? pageIndex;
  final int? totalPages;
  final List<T>? result;
  final int? totalCount;
  final bool? hasPreviousPage;
  final bool? hasNextPage;

  const PaginatedResponseDto({
    this.pageIndex,
    this.totalPages,
    this.result,
    this.totalCount,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory PaginatedResponseDto.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$PaginatedResponseDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginatedResponseDtoToJson(this, toJsonT);

  @override
  PaginatedResponseEntity<T> toEntity() => PaginatedResponseEntity<T>(
    pageIndex: pageIndex,
    totalPages: totalPages,
    result: result,
    totalCount: totalCount,
    hasPreviousPage: hasPreviousPage,
    hasNextPage: hasNextPage,
  );

  @override
  PaginatedResponseDto<T> fromEntity(PaginatedResponseEntity<T> entity) =>
      PaginatedResponseDto<T>(
        pageIndex: entity.pageIndex,
        totalPages: entity.totalPages,
        result: entity.result,
        totalCount: entity.totalCount,
        hasPreviousPage: entity.hasPreviousPage,
        hasNextPage: entity.hasNextPage,
      );
}
