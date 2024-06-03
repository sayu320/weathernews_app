// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_news_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SavedNewsModel _$SavedNewsModelFromJson(Map<String, dynamic> json) {
  return _SavedNewsModel.fromJson(json);
}

/// @nodoc
mixin _$SavedNewsModel {
  int? get id =>
      throw _privateConstructorUsedError; // Make id optional and nullable
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get urlToImage => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavedNewsModelCopyWith<SavedNewsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedNewsModelCopyWith<$Res> {
  factory $SavedNewsModelCopyWith(
          SavedNewsModel value, $Res Function(SavedNewsModel) then) =
      _$SavedNewsModelCopyWithImpl<$Res, SavedNewsModel>;
  @useResult
  $Res call(
      {int? id,
      String title,
      String description,
      String url,
      String urlToImage,
      DateTime publishedAt});
}

/// @nodoc
class _$SavedNewsModelCopyWithImpl<$Res, $Val extends SavedNewsModel>
    implements $SavedNewsModelCopyWith<$Res> {
  _$SavedNewsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? url = null,
    Object? urlToImage = null,
    Object? publishedAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlToImage: null == urlToImage
          ? _value.urlToImage
          : urlToImage // ignore: cast_nullable_to_non_nullable
              as String,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavedNewsModelImplCopyWith<$Res>
    implements $SavedNewsModelCopyWith<$Res> {
  factory _$$SavedNewsModelImplCopyWith(_$SavedNewsModelImpl value,
          $Res Function(_$SavedNewsModelImpl) then) =
      __$$SavedNewsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      String description,
      String url,
      String urlToImage,
      DateTime publishedAt});
}

/// @nodoc
class __$$SavedNewsModelImplCopyWithImpl<$Res>
    extends _$SavedNewsModelCopyWithImpl<$Res, _$SavedNewsModelImpl>
    implements _$$SavedNewsModelImplCopyWith<$Res> {
  __$$SavedNewsModelImplCopyWithImpl(
      _$SavedNewsModelImpl _value, $Res Function(_$SavedNewsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? url = null,
    Object? urlToImage = null,
    Object? publishedAt = null,
  }) {
    return _then(_$SavedNewsModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlToImage: null == urlToImage
          ? _value.urlToImage
          : urlToImage // ignore: cast_nullable_to_non_nullable
              as String,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedNewsModelImpl implements _SavedNewsModel {
  const _$SavedNewsModelImpl(
      {this.id,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt});

  factory _$SavedNewsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedNewsModelImplFromJson(json);

  @override
  final int? id;
// Make id optional and nullable
  @override
  final String title;
  @override
  final String description;
  @override
  final String url;
  @override
  final String urlToImage;
  @override
  final DateTime publishedAt;

  @override
  String toString() {
    return 'SavedNewsModel(id: $id, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedNewsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.urlToImage, urlToImage) ||
                other.urlToImage == urlToImage) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, url, urlToImage, publishedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedNewsModelImplCopyWith<_$SavedNewsModelImpl> get copyWith =>
      __$$SavedNewsModelImplCopyWithImpl<_$SavedNewsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedNewsModelImplToJson(
      this,
    );
  }
}

abstract class _SavedNewsModel implements SavedNewsModel {
  const factory _SavedNewsModel(
      {final int? id,
      required final String title,
      required final String description,
      required final String url,
      required final String urlToImage,
      required final DateTime publishedAt}) = _$SavedNewsModelImpl;

  factory _SavedNewsModel.fromJson(Map<String, dynamic> json) =
      _$SavedNewsModelImpl.fromJson;

  @override
  int? get id;
  @override // Make id optional and nullable
  String get title;
  @override
  String get description;
  @override
  String get url;
  @override
  String get urlToImage;
  @override
  DateTime get publishedAt;
  @override
  @JsonKey(ignore: true)
  _$$SavedNewsModelImplCopyWith<_$SavedNewsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
