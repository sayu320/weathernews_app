import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathernews_app/cubit/settings/settings_cubit.dart';
import 'package:weathernews_app/cubit/settings/settings_state.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SettingsCubit settingsCubit;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    settingsCubit = SettingsCubit(mockSharedPreferences);

    // Mocking the getInstance call to return the mockSharedPreferences
    when(() => mockSharedPreferences.getString(any())).thenReturn('');
    when(() => mockSharedPreferences.getStringList(any())).thenReturn([]);
    when(() => mockSharedPreferences.getBool(any())).thenReturn(false);
  });

  tearDown(() {
    settingsCubit.close();
  });

  blocTest<SettingsCubit, SettingsState>(
    'emits updated name when updateName is called',
    build: () {
      when(() => mockSharedPreferences.setString('name', 'Test Name'))
          .thenAnswer((_) async => true);
      return settingsCubit;
    },
    act: (cubit) => cubit.updateName('Test Name'),
    expect: () => [settingsCubit.state.copyWith(name: 'Test Name')],
  );

  blocTest<SettingsCubit, SettingsState>(
    'emits updated favorite categories when updateFavoriteCategories is called',
    build: () {
      when(() => mockSharedPreferences.setStringList('favoriteCategories', ['Category1', 'Category2']))
          .thenAnswer((_) async => true);
      return settingsCubit;
    },
    act: (cubit) => cubit.updateFavoriteCategories(['Category1', 'Category2']),
    expect: () => [settingsCubit.state.copyWith(favoriteCategories: ['Category1', 'Category2'])],
  );

  blocTest<SettingsCubit, SettingsState>(
    'emits updated city when updateCity is called',
    build: () {
      when(() => mockSharedPreferences.setString('city', 'New York'))
          .thenAnswer((_) async => true);
      return settingsCubit;
    },
    act: (cubit) => cubit.updateCity('New York'),
    expect: () => [settingsCubit.state.copyWith(city: 'New York')],
  );

  blocTest<SettingsCubit, SettingsState>(
    'emits updated theme when updateTheme is called',
    build: () {
      when(() => mockSharedPreferences.setBool('isDarkTheme', true))
          .thenAnswer((_) async => true);
      return settingsCubit;
    },
    act: (cubit) => cubit.updateTheme(true),
    expect: () => [settingsCubit.state.copyWith(isDarkTheme: true)],
  );
}
