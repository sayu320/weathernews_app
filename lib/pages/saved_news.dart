import 'package:flutter/material.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
      ),
      body: const Center(
        child: Text('Saved News Screen'),
      ),
    );
  }
}