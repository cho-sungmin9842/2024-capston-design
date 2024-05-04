import 'package:geolocator/geolocator.dart';

class Location {
  // late double latitude;
  // late double longitude;
  // 한성대 좌표 = '37.583350, 127.009536'
  double latitude = 37.583350;
  double longitude = 127.009536;
  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}