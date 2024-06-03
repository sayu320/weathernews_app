import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weathernews_app/models/saved_news_model.dart';
import 'package:weathernews_app/services/database_service.dart';

part 'saved_news_cubit.freezed.dart';
part 'saved_news_state.dart';

class SavedNewsCubit extends Cubit<SavedNewsState> {
  final DatabaseService _databaseService;

  SavedNewsCubit(this._databaseService) : super(const SavedNewsState.initial());

  Future<void> loadSavedNews() async {
    emit(const SavedNewsState.loading());
    try {
      final news = await _databaseService.getSavedNews();
      emit(SavedNewsState.loaded(news));
    } catch (e) {
      emit(SavedNewsState.error(e.toString()));
    }
  }

  Future<void> saveNews(SavedNewsModel news) async {
    await _databaseService.insertNews(news);
    loadSavedNews();
  }

  Future<void> deleteNews(int id) async {
    await _databaseService.deleteNews(id);
    loadSavedNews();
  }
    Future<bool> isNewsSaved(String url) async {
    final savedNewsList = await _databaseService.getSavedNews();
    return savedNewsList.any((news) => news.url == url);
  }
}