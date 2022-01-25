import 'package:elementary/elementary.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/service/map_service.dart';
import 'package:map_app/service/polylines_points_helper.dart';

class MapPageModel extends ElementaryModel {
  final MapService _mapService;
  final PolylinesPointsHelper _polylinePoints;

  MapPageModel(this._mapService, this._polylinePoints) : super();

  Future<Position?> getCurrentPosition() async {
    return _mapService.getCurrentPosition();
  }

  Future<PolylineResult> getRouteBetweenCoordinates(
    String apiKey,
    PointLatLng positionStart,
    PointLatLng positionFinish,
  ) {
    return _polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      positionStart,
      positionFinish,
    );
  }
}
