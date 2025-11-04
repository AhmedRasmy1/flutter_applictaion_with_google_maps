import 'package:flutter/material.dart';

void main() {
  runApp(const GoogleMapsWithFlutter());
}

class GoogleMapsWithFlutter extends StatelessWidget {
  const GoogleMapsWithFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Google Maps with Flutter')),
        body: const Center(child: Text('Google Maps integration goes here')),
      ),
    );
  }
}
