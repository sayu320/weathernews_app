import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathernews_app/cubit/settings/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SharedPreferences _sharedPreferences;

  SettingsCubit(this._sharedPreferences)
      : super(const SettingsState(
          name: '',
          favoriteCategories: [],
          city: '',
          isDarkTheme: false,
        )) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    String name = _sharedPreferences.getString('name') ?? '';
    List<String> favoriteCategories = _sharedPreferences.getStringList('favoriteCategories') ?? [];
    String city = _sharedPreferences.getString('city') ?? '';
    bool isDarkTheme = _sharedPreferences.getBool('isDarkTheme') ?? false;

    emit(state.copyWith(
      name: name,
      favoriteCategories: favoriteCategories,
      city: city,
      isDarkTheme: isDarkTheme,
    ));
  }

  Future<void> updateName(String name) async {
    await _sharedPreferences.setString('name', name);
    emit(state.copyWith(name: name));
  }

  Future<void> updateFavoriteCategories(List<String> categories) async {
    await _sharedPreferences.setStringList('favoriteCategories', categories);
    emit(state.copyWith(favoriteCategories: categories));
  }

  Future<void> updateCity(String city) async {
    await _sharedPreferences.setString('city', city);
    emit(state.copyWith(city: city));
  }

  Future<void> updateTheme(bool isDarkTheme) async {
    await _sharedPreferences.setBool('isDarkTheme', isDarkTheme);
    emit(state.copyWith(isDarkTheme: isDarkTheme));
  }

  List<String> get favoriteCategories => state.favoriteCategories;
}
