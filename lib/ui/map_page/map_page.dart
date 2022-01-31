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
      body: Stack(
        children: [
          EntityStateNotifierBuilder<Set<Polyline>>(
            listenableEntityState: wm.polylinesState,
            builder: (_, polylines) {
              return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(51.106437465167936, 71.42122559257321),
                  zoom: 14,
                ),
                myLocationEnabled: true,
                onMapCreated: wm.onMapCreated,
                polylines: polylines ?? {},
                markers: wm.markers,
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: wm.isInternetConnected,
            builder: (_, isConnected, __) {
              return !isConnected
                  ? Positioned(
                right: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text('no internet connection'),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                ),
              )
                  : const SizedBox();
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: wm.tryAgainButtonVisible,
        builder: (_, isVisible, __) {
          return isVisible ? FloatingActionButton.extended(
            label: const Text('try again'),
            onPressed: wm.generateRoute,
          ) : const SizedBox();
        },
      ),
    );
  }
}
