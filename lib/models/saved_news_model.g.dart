// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedNewsModelImpl _$$SavedNewsModelImplFromJson(Map<String, dynamic> json) =>
    _$SavedNewsModelImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$$SavedNewsModelImplToJson(
        _$SavedNewsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt.toIso8601String(),
    };
