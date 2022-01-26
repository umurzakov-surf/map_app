import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/service/map_service.dart';
import 'package:map_app/service/polylines_points_helper.dart';
import 'package:map_app/ui/map_page/map_page.dart';
import 'package:map_app/ui/map_page/map_page_model.dart';

MapPageWM mapPageWMFactory(BuildContext _) =>
    MapPageWM(MapPageModel(MapService(), PolylinesPointsHelper()));

class MapPageWM extends WidgetModel<MapPage, MapPageModel> {
  final Set<Polyline> polylines = <Polyline>{};
  final Set<Marker> markers = <Marker>{};
  final double zoom = 14;
  final List<LatLng> _polylineCoordinates = [];
  final String _googleAPiKey = 'AIzaSyA8DGaRfhhOPGNOdSPz-pCnZowUaugRJsg';
  final _polylinesState = EntityStateNotifier<Set<Polyline>>();

  ListenableState<EntityState<Set<Polyline>>> get polylinesState =>
      _polylinesState;

  MapPageWM(MapPageModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _polylinesState.content(polylines);
  }

  Future<void> onMapCreated(GoogleMapController _) async {
    await getPolyline();
  }

  Future<void> getPolyline() async {
    _polylinesState.loading();
    final position = await model.getCurrentPosition();

    if (position != null) {
      _addMarker(
        LatLng(widget.place.latitude, widget.place.longitude),
        'destination',
        BitmapDescriptor.defaultMarkerWithHue(90),
      );

      final result = await model.getRouteBetweenCoordinates(
        _googleAPiKey,
        PointLatLng(position.latitude, position.longitude),
        PointLatLng(widget.place.latitude, widget.place.longitude),
      );

      if (result.points.isNotEmpty) {
        for (final point in result.points) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      _addPolyLine();
      _polylinesState.content(polylines);
    }
  }

  void _addPolyLine() {
    const id = PolylineId('poly');
    polylines.add(
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
    markers.add(Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    ));
  }
}
