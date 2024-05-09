// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_meta_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageMetaEntity _$PageMetaEntityFromJson(Map<String, dynamic> json) =>
    PageMetaEntity(
      json['currentPage'] as int,
      json['lastPage'] as int,
      json['perPage'] as int,
      json['from'] as int,
      json['to'] as int,
      json['total'] as int,
    );

Map<String, dynamic> _$PageMetaEntityToJson(PageMetaEntity instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'lastPage': instance.lastPage,
      'perPage': instance.perPage,
      'from': instance.from,
      'to': instance.to,
      'total': instance.total,
    };
