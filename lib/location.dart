import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  String zipCode;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<String> getAddressFromLatLng() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      List<Placemark> p = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);

      zipCode = p[0].postalCode;
      return zipCode;
    } catch (e) {
      print(e);
    }
  }
}
