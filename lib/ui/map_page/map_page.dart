import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/model/map_place.dart';

class MapPage extends StatefulWidget {
  final MapPlace place;

  const MapPage({Key? key, required this.place}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<LatLng> _polylineCoordinates = [];
  final Set<Marker> _markers = <Marker>{};
  final Set<Polyline> _polylines = <Polyline>{};
  final String _googleAPiKey = 'AIzaSyA8DGaRfhhOPGNOdSPz-pCnZowUaugRJsg';
  final double _zoom = 14;
  late PolylinePoints _polylinePoints;

  @override
  void initState() {
    super.initState();
    _polylinePoints = PolylinePoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.place.name)),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(51.106437465167936, 71.42122559257321),
          zoom: _zoom,
        ),
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        polylines: _polylines,
        markers: _markers,
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController _) async {
    await _getPolyline();
  }

  Future<void> _getPolyline() async {
    final position = await _getCurrentPosition();

    if (position != null) {
      _addMarker(
        LatLng(widget.place.latitude, widget.place.longitude),
        'destination',
        BitmapDescriptor.defaultMarkerWithHue(90),
      );

      final result = await _polylinePoints.getRouteBetweenCoordinates(
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
    }
  }

  void _addPolyLine() {
    const id = PolylineId('poly');
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: _polylineCoordinates,
          width: 5,
        ),
      );
    });
  }

  void _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    final markerId = MarkerId(id);
    setState(() {
      _markers.add(Marker(
        markerId: markerId,
        icon: descriptor,
        position: position,
      ));
    });
  }

  Future<Position?> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return Geolocator.getCurrentPosition();
  }
}
