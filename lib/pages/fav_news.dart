import 'package:flutter/material.dart';

class FavoriteNewsScreen extends StatelessWidget {
  const FavoriteNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite News'),
      ),
      body: const Center(
        child: Text('Favorite News Screen'),
      ),
    );
  }
}