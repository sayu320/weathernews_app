import 'package:flutter/material.dart';
import 'package:weathernews_app/pages/all_news.dart';
import 'package:weathernews_app/pages/fav_news.dart';
import 'package:weathernews_app/pages/saved_news.dart';
import 'package:weathernews_app/pages/weather_info.dart';

class WeatherNewsPage extends StatefulWidget {
  const WeatherNewsPage({super.key});

  @override
  _WeatherNewsPageState createState() => _WeatherNewsPageState();
}

class _WeatherNewsPageState extends State<WeatherNewsPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const WeatherInfo(),
    const AllNewsScreen(),
    const FavoriteNewsScreen(),
    const SavedNewsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
         selectedItemColor: Colors.purpleAccent, // Color of the selected item
        unselectedItemColor: Colors.grey, // Color of the unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'All News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved News',
          ),
        ],
      ),
    );
  }
}