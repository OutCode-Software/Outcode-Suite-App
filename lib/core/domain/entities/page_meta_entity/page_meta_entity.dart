import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_meta_entity.g.dart';

@JsonSerializable()
class PageMetaEntity {
  PageMetaEntity(this.currentPage, this.lastPage, this.perPage, this.from,
      this.to, this.total);

  factory PageMetaEntity.fromJson(Map<String, dynamic> json) =>
      _$PageMetaEntityFromJson(json);
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int from;
  final int to;
  final int total;
  Map<String, dynamic> toJson() => _$PageMetaEntityToJson(this);
}
