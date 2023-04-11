import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice_ex/directions.dart' as webSr;
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
  Completer<GoogleMapController> _controllerCompleter = Completer();
  final LocatitonGeocoder geocoder = LocatitonGeocoder(mapApiKey);
  //-----Demo-Locations------//
  // destination point

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
  //-------Demo-Locations-----//

  static const LatLng dest = LatLng(23.6913, 85.2722);
  static const LatLng src = LatLng(19.0760, 72.8777);

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        mapApiKey,
        PointLatLng(src.latitude, src.longitude),
        PointLatLng(dest.latitude, dest.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));

      setState(() {});
    }
  }

  //-----------Get-Dstance-Price-------//
  final directions = webSr.GoogleMapsDirections(apiKey: mapApiKey);
  // void getDistancePrice() async {
  //   final result = await directions.directionsWithLocation(
  //       webSr.Location(lat: src.latitude, lng: src.longitude),
  //       webSr.Location(lat: dest.latitude, lng: dest.longitude));
  //   final distanceInMeters = result.routes.first.legs.first.distance.value;
  //   final distanceInKm = distanceInMeters / 1000;

  //   print("Distance" + distanceInKm.toString());
  // }

  //--------Init----------//
  @override
  void initState() {
    // getDistancePrice();
    addCustomIcon();
    getCurrentLocation(apiKey, addr, _controllerCompleter);

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
            buildingsEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
                target: LatLng(src.latitude, src.longitude),
                // target: LatLng(
                //     currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 5),
            polylines: {
              Polyline(
                  polylineId: const PolylineId('route'),
                  points: polylineCoordinates,
                  color: Colors.green,
                  width: 5)
            },
            markers: {
              Marker(
                  markerId: const MarkerId('currentLocation'),
                  infoWindow: InfoWindow(
                      title: "You", snippet: "this is your current location"),
                  position: LatLng(src.latitude, src.longitude)),
              // position: LatLng(
              //     currentLocation!.latitude!, currentLocation!.longitude!)),
              const Marker(markerId: MarkerId('source'), position: src),
              const Marker(markerId: MarkerId('destination'), position: dest)
            },
            onMapCreated: (controller) {
              _controllerCompleter.complete(controller);
              rootBundle.loadString('assets/jsons/darkMap.json').then((style) {
                _controllerCompleter.future.then((controller) {
                  controller.setMapStyle(style);
                });
              });
            },
          );
  }

  Future<void> getCurrentLocation(
    String apiKey,
    String? addr,
    Completer<GoogleMapController>? _controller,
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
      final GoogleMapController controller = await _controller!.future;
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
