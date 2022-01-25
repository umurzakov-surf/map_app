import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class PolylinesPointsHelper {
  final _polylines = PolylinePoints();

  Future<PolylineResult> getRouteBetweenCoordinates(
    String googleApiKey,
    PointLatLng origin,
    PointLatLng destination,
  ) async {
    return _polylines.getRouteBetweenCoordinates(
      googleApiKey,
      origin,
      destination,
    );
  }
}
