// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PagedDataImpl<T> _$$PagedDataImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$PagedDataImpl<T>(
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      meta: json['meta'] == null
          ? null
          : PageMetaData.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PagedDataImplToJson<T>(
  _$PagedDataImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data?.map(toJsonT).toList(),
      'meta': instance.meta,
    };
