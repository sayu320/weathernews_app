import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weathernews_app/consts/api_keys.dart';
import 'package:weathernews_app/cubit/settings/settings_cubit.dart';
import 'package:weathernews_app/cubit/settings/settings_state.dart';
import 'package:weathernews_app/pages/settings/settings_page.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({super.key});

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  String _greetingMessage = '';
  Weather? _weather;
  final WeatherFactory _weatherFactory = WeatherFactory(openWeatherApiKey);

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() {
    final settingsCubit = context.read<SettingsCubit>();
    final state = settingsCubit.state;
    final greeting = _getGreetingMessage(state.name);
    setState(() {
      _greetingMessage = greeting;
    });
    if (state.city.isNotEmpty) {
      _fetchWeatherInfo(state.city);
    }
  }

  String _getGreetingMessage(String name) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    return '$greeting\n$name';
  }

  Future<void> _fetchWeatherInfo(String city) async {
    try {
      final weather = await _weatherFactory.currentWeatherByCityName(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final greeting = _getGreetingMessage(state.name);
        if (state.city.isNotEmpty) {
          _fetchWeatherInfo(state.city);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Weather Info'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      greeting,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (state.city.isNotEmpty && _weather != null) _buildWeatherInfo() else Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeatherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _weather?.areaName ?? "",
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.20,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
                  ),
                ),
              ),
            ),
            Text(
              _weather?.weatherDescription ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 90,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.10,
          width: MediaQuery.sizeOf(context).width * 0.80,
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
