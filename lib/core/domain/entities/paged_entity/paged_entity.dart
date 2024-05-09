import '../page_meta_entity/page_meta_entity.dart';

class PagedEntity<T> {
  PagedEntity(this.pageEntity, this.data);
  final PageMetaEntity pageEntity;
  final List<T> data;
}
