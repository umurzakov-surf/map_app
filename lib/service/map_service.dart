import 'package:geolocator/geolocator.dart';
import 'package:map_app/custom_exceptions/custom_exception.dart';

class MapService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw CustomException('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw CustomException('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw CustomException('Location permissions are permanently denied, we cannot request permissions.');
    }

    return Geolocator.getCurrentPosition();
  }
}
