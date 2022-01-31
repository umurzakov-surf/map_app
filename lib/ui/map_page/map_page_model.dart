import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/custom_exceptions/custom_exception.dart';
import 'package:map_app/custom_exceptions/map_route_exception.dart';
import 'package:map_app/service/map_service.dart';
import 'package:map_app/service/polylines_points_helper.dart';

class MapPageModel extends ElementaryModel {
  final MapService _mapService;
  final PolylinesPointsHelper _polylinePoints;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];
  final String _googleAPiKey = 'AIzaSyA8DGaRfhhOPGNOdSPz-pCnZowUaugRJsg';

  Set<Marker> get markers => _markers;
  Set<Polyline> get polylines => _polylines;
  List<LatLng> get polylineCoordinates => _polylineCoordinates;

  MapPageModel(this._mapService, this._polylinePoints) : super();

  Future<Position> getCurrentPosition() async {
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

  Future<void> generateRoute({required double markLat, required double markLong}) async {
    late Position position;
    late PolylineResult polylineResult;

    try {
      position = await getCurrentPosition();
    } on CustomException catch (_) {
      rethrow;
    }

    _addMarker(
      LatLng(markLat, markLong),
      'destination',
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    polylineResult = await getRouteBetweenCoordinates(
      '${FlutterConfig.get('GOOGLE_MAP_API_KEY')}',
      PointLatLng(position.latitude, position.longitude),
      PointLatLng(markLat, markLong),
    );

    if (polylineResult.status == 'OK' && polylineResult.points.isNotEmpty) {
      for (final point in polylineResult.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      _addPolyLine();
    } else {
      throw MapRouteException();
    }
  }

  void _addPolyLine() {
    const id = PolylineId('poly');
    _polylines.add(
      Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: _polylineCoordinates,
        width: 5,
      ),
    );
  }

  void _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    final markerId = MarkerId(id);
    _markers.add(Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    ));
  }
}
