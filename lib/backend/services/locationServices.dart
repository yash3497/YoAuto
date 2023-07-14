import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoauto_task/constants/constant.dart';

class LocationServices {
  //-------Get User Current Location---------------//
  Future<Position?> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    pickupLat = position.latitude;
    pickupLng = position.longitude;
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

  static double fetchDistance(
      double lat1, double lng1, double lat2, double lng2) {
    double distanceInMeters = Geolocator.distanceBetween(
      lat1,
      lng1,
      lat2,
      lng2,
    );

    return distanceInMeters / 1000;
  }
}
