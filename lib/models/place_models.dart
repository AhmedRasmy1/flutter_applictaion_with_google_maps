import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModels {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModels({required this.id, required this.name, required this.latLng});
}

List<PlaceModels> places = [
  PlaceModels(
    id: 1,
    name: "شركة السلام للإلكترونيات",
    latLng: LatLng(28.498184935251192, 30.798806235826277),
  ),
  PlaceModels(
    id: 2,
    name: "أبو حجاج لكاوتش السيارات",
    latLng: LatLng(28.49759235429209, 30.79884344846018),
  ),
  PlaceModels(
    id: 3,
    name: "بيت الحج هشام ابو رسمي",
    latLng: LatLng(28.498444544953603, 30.797600971618134),
  ),
];
