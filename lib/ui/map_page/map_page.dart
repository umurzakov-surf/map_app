import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/service/model/map_place.dart';
import 'package:map_app/ui/map_page/map_page_wm.dart';

class MapPage extends ElementaryWidget<MapPageWM> {
  final MapPlace place;

  const MapPage({Key? key, required this.place})
      : super(mapPageWMFactory, key: key);

  @override
  Widget build(MapPageWM wm) {
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: EntityStateNotifierBuilder<Set<Polyline>>(
        listenableEntityState: wm.polylinesState,
        builder: (_, polylines) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: const LatLng(51.106437465167936, 71.42122559257321),
              zoom: wm.zoom,
            ),
            myLocationEnabled: true,
            onMapCreated: wm.onMapCreated,
            polylines: polylines ?? {},
            markers: wm.markers,
          );
        },
      ),
    );
  }
}
