import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/server/model/school.dart';
import 'package:geolocator/geolocator.dart';


mixin LocationMixin {

  Future<List<School>> findSchool(AccountApi accountApi) async {
    var position = await determinePosition();
    var latitude = position?.latitude ?? 0;
    var longitude = position?.longitude ?? 0;
    if (latitude == 0 || latitude == 0) {
      return [];
    } else {
      return await accountApi.getSchools(latitude, longitude);
    }
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // final hasPermission = await Permission.locationWhenInUse.serviceStatus.isEnabled;
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      try {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error(
              'Location permissions are denied, we cannot request permissions.');
        }
      } catch (e) {
        return Future.error(e);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Geolocator.getLastKnownPosition();
    // return Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.low, timeLimit: Duration(seconds: 10)));
  }
}
