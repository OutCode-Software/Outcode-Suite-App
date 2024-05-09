// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PagedData<T> _$PagedDataFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _PagedData<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PagedData<T> {
  List<T>? get data => throw _privateConstructorUsedError;
  PageMetaData? get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PagedDataCopyWith<T, PagedData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagedDataCopyWith<T, $Res> {
  factory $PagedDataCopyWith(
          PagedData<T> value, $Res Function(PagedData<T>) then) =
      _$PagedDataCopyWithImpl<T, $Res, PagedData<T>>;
  @useResult
  $Res call({List<T>? data, PageMetaData? meta});
}

/// @nodoc
class _$PagedDataCopyWithImpl<T, $Res, $Val extends PagedData<T>>
    implements $PagedDataCopyWith<T, $Res> {
  _$PagedDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PageMetaData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagedDataImplCopyWith<T, $Res>
    implements $PagedDataCopyWith<T, $Res> {
  factory _$$PagedDataImplCopyWith(
          _$PagedDataImpl<T> value, $Res Function(_$PagedDataImpl<T>) then) =
      __$$PagedDataImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T>? data, PageMetaData? meta});
}

/// @nodoc
class __$$PagedDataImplCopyWithImpl<T, $Res>
    extends _$PagedDataCopyWithImpl<T, $Res, _$PagedDataImpl<T>>
    implements _$$PagedDataImplCopyWith<T, $Res> {
  __$$PagedDataImplCopyWithImpl(
      _$PagedDataImpl<T> _value, $Res Function(_$PagedDataImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? meta = freezed,
  }) {
    return _then(_$PagedDataImpl<T>(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PageMetaData?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$PagedDataImpl<T> extends _PagedData<T> {
  const _$PagedDataImpl({final List<T>? data, this.meta})
      : _data = data,
        super._();

  factory _$PagedDataImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$PagedDataImplFromJson(json, fromJsonT);

  final List<T>? _data;
  @override
  List<T>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PageMetaData? meta;

  @override
  String toString() {
    return 'PagedData<$T>(data: $data, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagedDataImpl<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), meta);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PagedDataImplCopyWith<T, _$PagedDataImpl<T>> get copyWith =>
      __$$PagedDataImplCopyWithImpl<T, _$PagedDataImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PagedDataImplToJson<T>(this, toJsonT);
  }
}

abstract class _PagedData<T> extends PagedData<T> {
  const factory _PagedData({final List<T>? data, final PageMetaData? meta}) =
      _$PagedDataImpl<T>;
  const _PagedData._() : super._();

  factory _PagedData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$PagedDataImpl<T>.fromJson;

  @override
  List<T>? get data;
  @override
  PageMetaData? get meta;
  @override
  @JsonKey(ignore: true)
  _$$PagedDataImplCopyWith<T, _$PagedDataImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
