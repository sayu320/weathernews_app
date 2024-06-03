part of 'saved_news_cubit.dart';

@freezed
class SavedNewsState with _$SavedNewsState {
  const factory SavedNewsState.initial() = SavedNewsStateInitial;
  const factory SavedNewsState.loading() = SavedNewsStateLoading;
  const factory SavedNewsState.loaded(List<SavedNewsModel> news) = SavedNewsStateLoaded;
  const factory SavedNewsState.error(String message) = SavedNewsStateError;
}
