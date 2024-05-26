import 'package:flutter/material.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All News'),
      ),
      body: const Center(
        child: Text('All News Screen'),
      ),
    );
  }
}