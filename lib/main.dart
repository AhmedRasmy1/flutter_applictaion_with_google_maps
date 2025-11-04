import 'package:flutter/material.dart';
import 'package:flutter_applictaion_with_google_maps/widgets/custom_google_maps.dart';

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
        body: const CustomGoogleMaps(),
      ),
    );
  }
}
