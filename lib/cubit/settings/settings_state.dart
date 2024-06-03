import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required String name,
    required List<String> favoriteCategories,
    required String city,
    required bool isDarkTheme,
  }) = _SettingsState;
}