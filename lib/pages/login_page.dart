import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String _city = "";
  String _name = "";
  bool _nameValid = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _city = prefs.getString('city') ?? "";
      _name = prefs.getString('name') ?? "";
      _cityController.text = _city;
      _nameController.text = _name;
    });
  }

  Future<void> _saveCityName(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
  }

  Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
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

      if (response.isSuccessful) {
        final data = response.body;
        setState(() {
          _city = data!['city'] ?? "";
          _cityController.text = _city;
        });
        await _saveCityName(_city);
      } else {
        throw Exception('Failed to load city name');
      }
    } catch (e) {
      print(e);
    }
  }

  void _updateCityName() {
    setState(() {
      _city = _cityController.text;
    });
    _saveCityName(_city);
  }

  void _updateUserName() {
    setState(() {
      _name = _nameController.text;
    });
    _saveUserName(_name);
  }

  void _continue() {
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameValid = false;
      });
    } else {
      _updateUserName();
      if (_cityController.text.isNotEmpty) {
        _updateCityName();
      }
     // Navigate to the next page or perform any other action
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WeatherNewsPage()), // Placeholder for the next page
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(child:  Text('Weather & News App',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
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
                _updateUserName();
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
              onChanged: (value) {
                _updateCityName();
              },
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
            const SizedBox(height: 32),
            Text('Name: $_name'),
            const SizedBox(height: 8),
            Text('City: $_city'),
          ],
        ),
      ),
    );
  }
}
