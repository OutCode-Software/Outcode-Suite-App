import 'package:freezed_annotation/freezed_annotation.dart';

import '../page_meta_data/page_meta_data.dart';

part 'paged_data.freezed.dart';
part 'paged_data.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class PagedData<T> with _$PagedData<T> {
  const factory PagedData({List<T>? data, PageMetaData? meta}) = _PagedData<T>;
  const PagedData._();

  factory PagedData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PagedDataFromJson(json, fromJsonT);
}
