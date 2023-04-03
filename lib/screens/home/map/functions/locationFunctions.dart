import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yoauto_task/constants/ids.dart';

class LocationFunctions {
  static String? currentAddress;
  void getCurrentLocation(
    String apiKey,
    String? addr,
    LocationData? currentLocation,
    Completer<GoogleMapController> _controller,
  ) async {
    Location location = Location();

    location.getLocation().then((location) async {
      currentLocation = location;

      //---Get Address Details------//
      Fluttertoast.showToast(msg: location.latitude.toString());

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(location.latitude!, location.longitude!),
        zoom: 14,
      );

      //----------------------//
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      // var address = await Geocoder2.getDataFromCoordinates(
      //     latitude: location.latitude!,
      //     longitude: location.longitude!,
      //     googleMapApiKey: mapApiKey);
      // currentAddress = address.address;

      // addr = address.address;
      // print(addr);
    });
    // Fluttertoast.showToast(msg: addr!);

    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
    });
  }
}
