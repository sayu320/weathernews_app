import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathernews_app/cubit/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super( ThemeState.light());

  void toggleTheme(bool isDarkMode) {
    emit(isDarkMode ?  ThemeState.dark() :  ThemeState.light());
  }
}