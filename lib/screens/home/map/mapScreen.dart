import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:yoauto_task/constants/ids.dart';
import 'package:yoauto_task/screens/home/map/functions/locationFunctions.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String? currentAddress;
  String? addr;
  var apiKey = mapApiKey;
  Completer<GoogleMapController> _controller = Completer();
  final LocatitonGeocoder geocoder = LocatitonGeocoder(mapApiKey);

  //--------------Custom-Marker------------------//
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(5, 5)),
            "assets/images/autoMarker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  //-------------------------------------------//
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  //------Poly-Configs------/

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));

      setState(() {});
    }
  }

  //--------Init----------//
  @override
  void initState() {
    addCustomIcon();
    getCurrentLocation(apiKey, addr, _controller);

    print(currentLocation);
    getPolyPoints();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //------Markers-----------//
    final List<Marker> _markers = <Marker>[];

    return currentLocation == null
        ? const Center(
            child: Text("loading..."),
          )
        : GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5),
            polylines: {
              Polyline(
                  polylineId: PolylineId('route'),
                  points: polylineCoordinates,
                  color: Colors.green,
                  width: 5)
            },
            markers: {
              Marker(
                  markerId: const MarkerId('currentLocation'),
                  icon: markerIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!)),
              const Marker(
                  markerId: MarkerId('source'), position: sourceLocation),
              const Marker(
                  markerId: MarkerId('destination'), position: destination)
            },
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
          );
  }

  Future<void> getCurrentLocation(
    String apiKey,
    String? addr,
    Completer<GoogleMapController> _controller,
  ) async {
    Location location = Location();

    location.getLocation().then((location) async {
      setState(() {
        currentLocation = location;
      });
      print(currentLocation);

      //---Get Address Details------//
      Fluttertoast.showToast(msg: location.latitude.toString());

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(location.latitude!, location.longitude!),
        zoom: 14,
      );
      Timer(Duration(seconds: 2), () {});
      // convertToAddress(location);

      //----------------------//
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      // var address = await Geocoder2.getDataFromCoordinates(
      //     latitude: location.latitude!,
      //     longitude: location.longitude!,
      //     googleMapApiKey: mapApiKey);
    });
    // Fluttertoast.showToast(msg: addr!);

    location.onLocationChanged.listen((newLocation) {
      setState(() {
        currentLocation = newLocation;
      });
    });
  }

  // void convertToAddress(LocationData? location) async {
  //   var address = await geocoder.findAddressesFromCoordinates(
  //       Coordinates(location?.latitude, location?.longitude));

  //   print(address.first.postalCode ?? "Still Empty");
  // }

  //------Get User Current Location-------//
  // Future<Position> getUserCurrentLocation() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) async {
  //     await Geolocator.requestPermission();
  //     print("ERROR" + error.toString());
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }

}
