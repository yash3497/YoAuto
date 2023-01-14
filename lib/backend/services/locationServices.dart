import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationServices {
  //-------Get User Current Location---------------//
  Future<Position?> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double lng = position.longitude;

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble('lat', lat);
    _prefs.setDouble('lng', lng);

    Fluttertoast.showToast(
        msg: "Lattitude : " + "$lat" + "\nLongitude : " + "$lng");
  }

  // Check if location service is enabled
  bool _serviceEnabled = false;

  static void checkServiceAndPermission() async {
    if (await Permission.location.isDenied) {
      await Permission.location.request();
      if (await Permission.location.isDenied) {
        Fluttertoast.showToast(msg: "Location Permission Denied!");
      } else {
        Fluttertoast.showToast(msg: "Permission Granted");
      }
      // Use location.
    } else {
      LocationServices().getUserLocation();
    }
  }
}
