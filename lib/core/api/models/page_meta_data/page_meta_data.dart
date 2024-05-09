import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/page_meta_entity/page_meta_entity.dart';

part 'page_meta_data.g.dart';

@JsonSerializable()
class PageMetaData {
  PageMetaData(this.currentPage, this.lastPage, this.perPage, this.from,
      this.to, this.total);

  factory PageMetaData.fromJson(Map<String, dynamic> json) =>
      _$PageMetaDataFromJson(json);
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'last_page')
  final int lastPage;
  @JsonKey(name: 'per_page')
  final int perPage;
  final int from;
  final int to;
  final int total;
  Map<String, dynamic> toJson() => _$PageMetaDataToJson(this);

  PageMetaEntity asEntity() =>
      PageMetaEntity(currentPage, lastPage, perPage, from, to, total);
}
