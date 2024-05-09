// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageMetaData _$PageMetaDataFromJson(Map<String, dynamic> json) => PageMetaData(
      json['current_page'] as int,
      json['last_page'] as int,
      json['per_page'] as int,
      json['from'] as int,
      json['to'] as int,
      json['total'] as int,
    );

Map<String, dynamic> _$PageMetaDataToJson(PageMetaData instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'from': instance.from,
      'to': instance.to,
      'total': instance.total,
    };
