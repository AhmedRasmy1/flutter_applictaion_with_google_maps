import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(28.5036, 30.8008),
      zoom: 12,
    );
    super.initState();
  }

  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            mapController = controller;
            initMapStyle();
          },
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: LatLng(28.4900, 30.7900),
          //     northeast: LatLng(28.5200, 30.8100),
          //   ),
          // ),
        ),

        Positioned(
          left: 16,
          bottom: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              // CameraPosition newLocation = const CameraPosition(
              //   target: LatLng(28.4976, 30.8038),
              //   zoom: 15,
              // );
              // mapController.animateCamera(
              //   CameraUpdate.newCameraPosition(newLocation),
              // );
            },
            child: const Text('My Location'),
          ),
        ),
      ],
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/night_map_style.json');
    mapController.setMapStyle(nightMapStyle);
  }
}
