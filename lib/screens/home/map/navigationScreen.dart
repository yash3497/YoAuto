import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/home/map/mapScreen.dart';
import 'package:yoauto_task/screens/home/map/mapmyindia.dart';
import 'package:yoauto_task/screens/home/map/navigation/inform.dart';

import '../book_ride_screen.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({
    super.key,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
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

    setState(() {
      pickupLat = pickupLt;
      dropLat = dropLt;
      pickupLong = pickupLg;
      dropLong = dropLg;
    });
    print(pickupLong);
  }

  Future<void> addPolyline() async {
    Line? line = await mapController?.addLine(LineOptions(geometry: [
      LatLng(pickupLat!, pickupLong!),
      LatLng(dropLat!, dropLong!)
    ], lineColor: "#0000FF", lineWidth: 5));
  }

  bool isOpen = false;
  void initState() {
    getEnteredLocations();
    MapmyIndiaAccountManager.setMapSDKKey(
        '7b882118-827e-4edb-ba1d-49b543207ab8');
    MapmyIndiaAccountManager.setRestAPIKey('167140dcd36d6813b79a4d1804928dde');
    MapmyIndiaAccountManager.setAtlasClientId(
        '33OkryzDZsJql_ZA4qDdX0RQfftjgQIAuMwG4H3FzlhKGZX4Tx3ilO75KiS0ICCEP3JZKNxikbD7UyF_rAqDcQ==');
    MapmyIndiaAccountManager.setAtlasClientSecret(
        'lrFxI-iSEg-GX5ify7ZXE-mxSkW_fpfJUsNsC5NJpXyoUTXmsjzWxvWF0olV-ofebJ_xJRhFu2jXlXEjG6-TPk5yfOgu0XwK');
    addPolyline();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.amber.shade300,
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: MapmyIndiaMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(pickupLat ?? 19.0760, pickupLong ?? 72.8777),
          zoom: 14.0,
        ),
        myLocationEnabled: true,
        trackCameraPosition: true,
        onMapCreated: (map) => {
          mapController = map,
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: CircleAvatar(
          backgroundColor: Vx.red500,
          radius: isOpen ? 30 : 30,
          child: Center(
            child: Icon(
              isOpen ? Icons.cancel_outlined : Icons.dangerous_rounded,
              size: isOpen ? 38 : 60,
            ),
          ),
        ),
      ),
      bottomSheet: isOpen
          ? Container(
              height: context.screenHeight / 4.5,
              width: context.screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
              child: Column(
                children: [
                  Text(
                    "Something Strange?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ).pOnly(top: 20),
                  InkWell(
                    onTap: (() {
                      Get.to(InformUsScreen());
                    }),
                    child: Container(
                        height: 50,
                        width: context.screenWidth / 1.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Inform Us",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )).pOnly(top: 30),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "Click here to report issue",
                          style: TextStyle(color: Colors.red),
                        ),
                      ))
                ],
              ),
            )
          : SizedBox(),
    );
  }
}
