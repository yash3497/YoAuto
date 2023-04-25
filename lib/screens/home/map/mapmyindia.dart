import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if (mounted) {
      setState(() {});
    }
  }

  //----Marekrs-------//
  Future<void> addMarkers() async {
    Symbol? symbol = await mapController
        ?.addSymbol(SymbolOptions(geometry: LatLng(25.321684, 82.987289)));
  }

  @override
  void initState() {
    getEnteredLocations();
    MapmyIndiaAccountManager.setMapSDKKey(
        '7b882118-827e-4edb-ba1d-49b543207ab8');
    MapmyIndiaAccountManager.setRestAPIKey('167140dcd36d6813b79a4d1804928dde');
    MapmyIndiaAccountManager.setAtlasClientId(
        '33OkryzDZsJql_ZA4qDdX0RQfftjgQIAuMwG4H3FzlhKGZX4Tx3ilO75KiS0ICCEP3JZKNxikbD7UyF_rAqDcQ==');
    MapmyIndiaAccountManager.setAtlasClientSecret(
        'lrFxI-iSEg-GX5ify7ZXE-mxSkW_fpfJUsNsC5NJpXyoUTXmsjzWxvWF0olV-ofebJ_xJRhFu2jXlXEjG6-TPk5yfOgu0XwK');

    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return MapmyIndiaMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(pickupLat!, pickupLong!),
        zoom: 14.0,
      ),
      myLocationEnabled: true,
      trackCameraPosition: true,
      onMapCreated: (map) => {
        mapController = map,
      },
    );
  }
}
