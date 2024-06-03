import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_news_model.freezed.dart';
part 'saved_news_model.g.dart';

@freezed
class SavedNewsModel with _$SavedNewsModel {
  const factory SavedNewsModel({
    int? id, // Make id optional and nullable
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required DateTime publishedAt,
  }) = _SavedNewsModel;

  factory SavedNewsModel.fromJson(Map<String, dynamic> json) => _$SavedNewsModelFromJson(json);
}