// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponseDto<T> _$PaginatedResponseDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginatedResponseDto<T>(
      pageIndex: (json['pageIndex'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      result: (json['result'] as List<dynamic>?)?.map(fromJsonT).toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
    );

Map<String, dynamic> _$PaginatedResponseDtoToJson<T>(
  PaginatedResponseDto<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'totalPages': instance.totalPages,
      'result': instance.result?.map(toJsonT).toList(),
      'totalCount': instance.totalCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };
