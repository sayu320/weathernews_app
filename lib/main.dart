import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weathernews_app/cubit/saved_news_cubit.dart';
import 'package:weathernews_app/cubit/settings/settings_cubit.dart';
import 'package:weathernews_app/cubit/theme/theme_cubit.dart';
import 'package:weathernews_app/cubit/theme/theme_state.dart';
import 'package:weathernews_app/pages/login_page.dart';
import 'package:weathernews_app/services/bigdata_cloud_services.dart';
import 'package:weathernews_app/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider<BigDataCloudService>(
          create: (context) => BigDataCloudService.create(),
          dispose: (context, BigDataCloudService service) => service.client.dispose(),
        ),
        BlocProvider<SavedNewsCubit>(
          create: (context) => SavedNewsCubit(DatabaseService()),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(sharedPreferences),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          theme: FlexColorScheme.light(scheme: FlexScheme.hippieBlue).toTheme,
          darkTheme: FlexColorScheme.dark(scheme: FlexScheme.hippieBlue).toTheme,
          themeMode: themeState.themeMode,
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
        );
      },
    );
  }
}
