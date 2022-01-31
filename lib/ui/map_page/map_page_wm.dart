import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/custom_exceptions/custom_exception.dart';
import 'package:map_app/custom_exceptions/map_route_exception.dart';
import 'package:map_app/service/dialog_helper.dart';
import 'package:map_app/service/map_service.dart';
import 'package:map_app/service/polylines_points_helper.dart';
import 'package:map_app/ui/map_page/map_page.dart';
import 'package:map_app/ui/map_page/map_page_model.dart';
import 'package:map_app/ui/map_page/widgets/error_map_modal.dart';

MapPageWM mapPageWMFactory(BuildContext _) =>
    MapPageWM(
      MapPageModel(MapService(), PolylinesPointsHelper()),
      DialogHelper(),
    );

class MapPageWM extends WidgetModel<MapPage, MapPageModel> {
  final _polylinesState = EntityStateNotifier<Set<Polyline>>();
  final Connectivity _connectivity = Connectivity();
  final ValueNotifier<bool> _isIntenetConnected = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _tryAgainButtonVisible = ValueNotifier<bool>(false);

  final DialogHelper _dialogHelper;

  Set<Marker> get markers => model.markers;
  Set<Polyline> get polylines => model.polylines;

  ListenableState<EntityState<Set<Polyline>>> get polylinesState =>
      _polylinesState;

  ValueListenable<bool> get isInternetConnected => _isIntenetConnected;
  ValueListenable<bool> get tryAgainButtonVisible => _tryAgainButtonVisible;

  late StreamSubscription<ConnectivityResult> _connectivityStreamSubscription;

  MapPageWM(MapPageModel model, this._dialogHelper) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _initConnectivity();
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
    _polylinesState.content(polylines);
  }

  @override
  void dispose() {
    _connectivityStreamSubscription.cancel();
    super.dispose();
  }

  Future<void> onMapCreated(GoogleMapController _) async {
    await generateRoute();
  }

  Future<void> generateRoute() async {
    _polylinesState.loading();
    if (_isIntenetConnected.value) {
      try {
        await model.generateRoute(
          markLat: widget.place.latitude, markLong: widget.place.longitude,);
      } on CustomException catch (e) {
        _showSnack(e.cause);
      } on MapRouteException catch (_) {
        await _showModal();
      }
      _tryAgainButtonVisible.value = polylines.isEmpty;
    }
    _polylinesState.content(polylines);
  }

  Future<void> _initConnectivity() async {
    late ConnectivityResult _connectionResult;

    try {
      _connectionResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      _showSnack('${e.message}');
    }

    await _updateConnectivityStatus(_connectionResult);
  }

  Future<void> _updateConnectivityStatus(ConnectivityResult result) async {
    _isIntenetConnected.value = result != ConnectivityResult.none;
  }

  Future<void> _showModal() async {
    await _dialogHelper.showCustomDialog<String>(
      context: context,
      builder: (context) => const ErrorMapModal(),
    );
    _polylinesState.content(polylines);
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
