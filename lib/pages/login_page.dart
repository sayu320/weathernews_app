import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weathernews_app/cubit/settings/settings_cubit.dart';
import 'package:weathernews_app/pages/weathernews_page.dart';
import 'package:weathernews_app/services/bigdata_cloud_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _nameValid = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final settingsCubit = context.read<SettingsCubit>();
    final state = settingsCubit.state;
    setState(() {
      _cityController.text = state.city;
      _nameController.text = state.name;
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoading = false;
        });
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoading = false;
          });
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
        });
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition();
      print('Current position: ${position.latitude}, ${position.longitude}');
      await _getCityNameFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

Future<void> _getCityNameFromCoordinates(double latitude, double longitude) async {
  try {
    final bigDataCloudService = Provider.of<BigDataCloudService>(context, listen: false);
      final response = await bigDataCloudService.getCityName(latitude, longitude, 'en');
      print('BigDataCloud response: ${response.body}');

      if (response.isSuccessful) {
        final data = response.body;
        setState(() {
          _cityController.text = data?['city'] ?? "";
        });
        context.read<SettingsCubit>().updateCity(_cityController.text);
      } else {
        throw Exception('Failed to load city name');
      }
    } catch (e) {
      print(e);
    }
  }

  void _continue() {
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameValid = false;
      });
    } else {
      context.read<SettingsCubit>().updateName(_nameController.text);
      context.read<SettingsCubit>().updateCity(_cityController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WeatherNewsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Weather & News App',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                errorText: _nameValid ? null : 'Name is required',
              ),
              onChanged: (value) {
                setState(() {
                  _nameValid = true;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name (optional)',
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _getCurrentLocation,
                    child: const Text('Autofill City Name'),
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _continue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
