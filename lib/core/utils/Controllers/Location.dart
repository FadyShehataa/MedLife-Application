import 'dart:math';

import '../../../modules/PATIENT/Prescription OCR/data/models/prescription_model/prescription_model.dart';

class Coordinate {
  double lat; // Updated: latitude

  double long; // Updated: longitude

  Coordinate(this.lat, this.long);
}



List<PrescriptionModel> sortByDistance(Coordinate coordinate, List<PrescriptionModel> items) {
  items.sort((a, b) {
    final double distanceA = calculateDistance(
        coordinate.lat, coordinate.long,
        a.product!.pharmacy!.location!.lat! is int ? (a.product!.pharmacy!.location!.lat! as int).toDouble() : (a.product!.pharmacy!.location!.lat!) as double,
        a.product!.pharmacy!.location!.lng! is int ? (a.product!.pharmacy!.location!.lng! as int).toDouble() : (a.product!.pharmacy!.location!.lng!) as double);
    final double distanceB = calculateDistance(
        coordinate.lat, coordinate.long,
        b.product!.pharmacy!.location!.lat! is int ? (b.product!.pharmacy!.location!.lat! as int).toDouble() : (b.product!.pharmacy!.location!.lat!) as double,
        b.product!.pharmacy!.location!.lng! is int ? (b.product!.pharmacy!.location!.lng! as int).toDouble() : (b.product!.pharmacy!.location!.lng!) as double); // Updated: lat, long order
    return distanceA.compareTo(distanceB);
  });
  return items;
}

double calculateDistance(
    double fromLat, double fromLong, double toLat, double toLong) { // Updated: lat, long order
  double radius = 6378137; // approximate Earth radius in meters
  double deltaLat = toLat - fromLat;
  double deltaLong = toLong - fromLong;
  double angle = 2 *
      asin(sqrt(pow(sin(deltaLat / 2), 2) +
          cos(fromLat) *
              cos(toLat) *
              pow(sin(deltaLong / 2), 2)));
  return radius * angle;
}