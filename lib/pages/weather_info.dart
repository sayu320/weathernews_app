import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({super.key});

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  String _greetingMessage = '';

  @override
  void initState() {
    super.initState();
    _loadGreeting();
  }

  Future<void> _loadGreeting() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? 'User';
    final greeting = _getGreetingMessage(name);
    setState(() {
      _greetingMessage = greeting;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Info'),
      ),
      body: Column(
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
                _greetingMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          
        ],
      ),
    );
  }
}
