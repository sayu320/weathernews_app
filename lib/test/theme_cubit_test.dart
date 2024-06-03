import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weathernews_app/cubit/theme/theme_cubit.dart';
import 'package:weathernews_app/cubit/theme/theme_state.dart';

void main() {
  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits [ThemeState.dark] when toggleTheme is called with true',
      build: () => themeCubit,
      act: (cubit) => cubit.toggleTheme(true),
      expect: () => [ThemeState.dark()],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits [ThemeState.light] when toggleTheme is called with false',
      build: () => themeCubit,
      act: (cubit) => cubit.toggleTheme(false),
      expect: () => [ThemeState.light()],
    );
  });
}