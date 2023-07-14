import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/home/map/mapScreen.dart';
import 'package:yoauto_task/screens/home/map/mapmyindia.dart';
import 'package:yoauto_task/screens/home/map/navigation/inform.dart';

import '../book_ride_screen.dart';

class NavigationScreen extends StatefulWidget {
  double? pickupLat;
  double? pickupLng;
  double? dropLat;
  double? dropLng;
  String? driverID;
  NavigationScreen(
      {super.key,
      this.pickupLat,
      this.pickupLng,
      this.dropLat,
      this.dropLng,
      this.driverID});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
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

  //----------Get-Data---------//
  Set<Marker> _markers = {};
  final CollectionReference<Map<String, dynamic>> locationCollection =
      FirebaseFirestore.instance.collection('drivers');

  Stream<Map<String, double>> getLocationStream() {
    return locationCollection.doc(widget.driverID).snapshots().map((event) {
      final data = event.data()!['livelocation'];
      final double latitude = data['latitude'] as double;
      final double longitude = data['longitude'] as double;
      return {'latitude': latitude, 'longitude': longitude};
    });
  }

  bool isOpen = false;
  void initState() {
    getEnteredLocations();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getLocationStream().listen((data) {
        setState(() {
          _markers.clear();
          _markers.add(Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(data['latitude']!, data['longitude']!),
            icon: BitmapDescriptor.defaultMarker,
          ));
        });
      });
    });

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
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(pickupLat ?? 0, pickupLong ?? 0)),
        markers: _markers,
        polylines: {
          Polyline(
              points: [
                LatLng(pickupLat ?? 0, pickupLong ?? 0),
                LatLng(dropLat ?? 2, dropLong ?? 2)
              ],
              color: Colors.amber.shade900,
              polylineId: const PolylineId('navigationRoute'))
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
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
              child: Column(
                children: [
                  const Text(
                    "Something Strange?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ).pOnly(top: 20),
                  InkWell(
                    onTap: (() {
                      Get.to(const InformUsScreen());
                    }),
                    child: Container(
                        height: 50,
                        width: context.screenWidth / 1.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            "Inform Us",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )).pOnly(top: 30),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Center(
                        child: Text(
                          "Click here to report issue",
                          style: TextStyle(color: Colors.red),
                        ),
                      ))
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
