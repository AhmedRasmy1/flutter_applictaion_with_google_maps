import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_applictaion_with_google_maps/models/place_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:location/location.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  late Location location;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(28.5036, 30.8008),
      zoom: 9,
    );
    location = Location();
    updataMylocation();
    // initMarkers();
    // initPolylines();
    // initPolygones();
    // initCircles();
    super.initState();
  }

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          circles: circles,
          polylines: polylines,
          polygons: polygons,
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

        // Positioned(
        //   left: 16,
        //   bottom: 16,
        //   right: 16,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       CameraPosition newLocation = const CameraPosition(
        //         target: LatLng(28.4976, 30.8038),
        //         zoom: 15,
        //       );
        //       mapController.animateCamera(
        //         CameraUpdate.newCameraPosition(newLocation),
        //       );
        //     },
        //     child: const Text('My Location'),
        //   ),
        // ),
      ],
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/night_map_style.json');
    mapController.setMapStyle(nightMapStyle);
  }

  Future<void> checkAndRequestLocationService() async {
    var isEnabledService = await location.serviceEnabled();
    if (!isEnabledService) {
      await location.requestService();
      if (!isEnabledService) {
        //! show some message to user
        return;
      }
    }
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void getLocationData() {
    location.onLocationChanged.listen((locationData) {});
  }

  void updataMylocation() async {
    await checkAndRequestLocationService();
    var hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) {
      getLocationData();
    }
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
      await getImageFromRawData("assets/images/map_marker.png", 100),
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

  void initPolylines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId('1'),
      points: [
        LatLng(28.497577444185065, 30.798768856059553),
        LatLng(28.498152605585627, 30.798704483042357),
        LatLng(28.498435047746746, 30.797629083348788),
      ],
    );
    polylines.add(polyline);
  }

  void initPolygones() {
    Polygon polygon = Polygon(
      strokeWidth: 3,
      fillColor: Colors.black.withOpacity(0.6),
      polygonId: PolygonId('1'),
      points: [
        LatLng(28.50466791769032, 30.798407434727466),
        LatLng(28.50249556954353, 30.801348554366495),
        LatLng(28.499609607104244, 30.79492500469991),
      ],
    );
    polygons.add(polygon);
  }

  void initCircles() {
    Circle circle = Circle(
      circleId: CircleId("1"),
      center: LatLng(28.502784621141846, 30.801001576601536),
      radius: 5000,
    );
    circles.add(circle);
  }
}
