import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_applictaion_with_google_maps/models/place_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
    initMarkers();
    super.initState();
  }

  Set<Marker> markers = {};
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
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

  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );
    var imageFram = await imageCodec.getNextFrame();
    var imageByteData = await imageFram.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return imageByteData!.buffer.asUint8List();
  }

  void initMarkers() async {
    BitmapDescriptor customMarkerIcon = BitmapDescriptor.fromBytes(
      await getImageFromRawData("assets/images/map_marker.png", 200),
    );

    var myMarkers = places
        .map(
          (placesModel) => Marker(
            markerId: MarkerId(placesModel.id.toString()),
            position: placesModel.latLng,
            infoWindow: InfoWindow(title: placesModel.name),
            icon: customMarkerIcon,
          ),
        )
        .toSet();

    markers.addAll(myMarkers);
    setState(() {});
  }
}
