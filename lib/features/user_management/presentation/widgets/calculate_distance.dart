import 'package:geolocator/geolocator.dart';

double calculateDistance(
  double myLat,
  double myLon,
  double docLat,
  double docLon,
) {
  final distance = Geolocator.distanceBetween(myLat, myLon, docLat, docLon);
  return distance / 1000;
}
