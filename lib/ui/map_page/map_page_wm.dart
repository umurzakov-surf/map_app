import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/service/dialog_helper.dart';
import 'package:map_app/service/map_service.dart';
import 'package:map_app/service/polylines_points_helper.dart';
import 'package:map_app/ui/map_page/map_page.dart';
import 'package:map_app/ui/map_page/map_page_model.dart';
import 'package:map_app/ui/map_page/widgets/error_map_modal/error_map_modal.dart';

MapPageWM mapPageWMFactory(BuildContext _) =>
    MapPageWM(
      MapPageModel(MapService(), PolylinesPointsHelper()), DialogHelper(),);

class MapPageWM extends WidgetModel<MapPage, MapPageModel> {
  final Set<Polyline> polylines = <Polyline>{};
  final Set<Marker> markers = <Marker>{};
  final List<LatLng> _polylineCoordinates = [];
  final String _googleAPiKey = 'AIzaSyA8DGaRfhhOPGNOdSPz-pCnZowUaugRJsg';
  final _polylinesState = EntityStateNotifier<Set<Polyline>>();

  final DialogHelper _dialogHelper;

  ListenableState<EntityState<Set<Polyline>>> get polylinesState =>
      _polylinesState;

  MapPageWM(MapPageModel model, this._dialogHelper) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _polylinesState.content(polylines);
  }

  Future<void> onMapCreated(GoogleMapController _) async {
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

      if (result.status == 'OK' && result.points.isNotEmpty) {
        for (final point in result.points) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        await _showModal();
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

  Future<void> _showModal() async {
    await _dialogHelper.showCustomDialog<String>(
      context: context,
      builder: (context) => const ErrorMapModal(),
    );
  }
}
