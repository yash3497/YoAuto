import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoauto_task/constants/constant.dart';
import 'package:yoauto_task/screens/home/map/functions/mapConfigs.dart';

class MapMyIndiaScreen extends StatefulWidget {
  const MapMyIndiaScreen({super.key});

  @override
  State<MapMyIndiaScreen> createState() => _MapMyIndiaScreenState();
}

class _MapMyIndiaScreenState extends State<MapMyIndiaScreen> {
  MapmyIndiaMapController? mapController;

  double? pickupLat;
  double? dropLat;
  double? pickupLong;
  double? dropLong;
  getEnteredLocations() async {
    var prefs = await SharedPreferences.getInstance();
    var pickupLt = prefs.getDouble('pickupLat');
    var dropLt = prefs.getDouble('dropLat');
    var pickupLg = prefs.getDouble('pickupLong');
    var dropLg = prefs.getDouble('dropLong');
    pickupLat = pickupLt;
    dropLat = dropLt;
    pickupLong = pickupLg;
    dropLong = dropLg;

    print("Pickup Location: $pickupLat, $pickupLong");
    // if (mounted) {
    //   setState(() {});
    // }
  }

  //----Marekrs-------//
  Future<void> addMarkers() async {
    Symbol? symbol = await mapController
        ?.addSymbol(SymbolOptions(geometry: LatLng(25.321684, 82.987289)));
  }

  @override
  void initState() {
    // getEnteredLocations();
    MapMyIndiaConfigs();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getEnteredLocations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MapmyIndiaMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(pickupLat ?? 0, pickupLong ?? 0),
                zoom: 14.0,
              ),
              myLocationEnabled: true,
              trackCameraPosition: true,
              onMapCreated: (map) => {
                mapController = map,
              },
            );
          }
          return CircularProgressIndicator();
        });
  }
}
