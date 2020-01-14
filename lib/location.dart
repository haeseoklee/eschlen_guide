import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<Map> getCurrentLocation() async {
    Map location = {
      'latitude': 37.300436,
      'longitude': 126.837846,
    };

    try {
      Geolocator geolocator = Geolocator();
      if (await geolocator.isLocationServiceEnabled()){
        Position position = await geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        location['latitude'] = position.latitude;
        location['longitude'] = position.longitude;
      }
      return (location);
    } catch (e) {
      print(e);
    }
  }
}
