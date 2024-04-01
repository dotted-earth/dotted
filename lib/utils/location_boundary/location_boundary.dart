import 'dart:math';

class LocationBoundary {
  static double milesToDegrees(double miles) {
    return miles / 69;
  }

  static double kmToDegrees(double km) {
    return km / 111;
  }

  Map<String, double> calcBoundingBox(
      double lat, double lon, double? miles, double? km) {
    if (miles == null && km == null) {
      throw "Must provide miles or km";
    }
    double latDegrees = 0;
    double lonDegrees = 0;
    var radians = lat * (pi / 180);
    if (miles != null) {
      latDegrees = milesToDegrees(miles);
      lonDegrees = milesToDegrees(miles) / cos(radians);
    }
    if (km != null) {
      latDegrees = milesToDegrees(km);
      lonDegrees = milesToDegrees(km) / cos(radians);
    }

    final north = lat + latDegrees;
    final south = lat - latDegrees;
    final east = lon + lonDegrees;
    final west = lon - lonDegrees;

    return {'north': north, 'south': south, 'east': east, 'west': west};
  }
}
