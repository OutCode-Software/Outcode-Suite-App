// ignore_for_file: unnecessary_this

extension MyList<T> on List<T> {
  T? get firstOrNull => this.isEmpty ? null : this.first;
  T? get lastOrNull => this.isEmpty ? null : this.last;
}
