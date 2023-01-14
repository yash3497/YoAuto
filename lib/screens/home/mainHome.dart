// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoauto_task/backend/services/locationServices.dart';
import 'package:yoauto_task/screens/CurrentRide/current_ride.dart';
import 'package:yoauto_task/screens/wallet/wallet_screen.dart';
import 'package:yoauto_task/widget/custom_drawer_btn.dart';
import 'package:yoauto_task/widget/widget.dart';

import '../../widget/custom_drawerScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //-----Google-Map-Configs------//
  //----Controller-------//
  Completer<GoogleMapController> _controller = Completer();
// on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(30.316496, 78.032188),
    zoom: 14.4746,
  );

// on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(30.316496, 78.032188),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  //--------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
            onTap: (() {
              _scaffoldKey.currentState?.openDrawer();
            }),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDrawerBtn(),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomBellBtn(),
          )
        ],
      ),
      drawer: Drawer(
        elevation: 30,
        child: CustomDrawerScreen(),
      ),
      body: SafeArea(
        child: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            markers: Set<Marker>.of(_markers),
            initialCameraPosition: _kGoogle,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          HomeContainer()
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(
                value!.latitude.toString() + " " + value!.longitude.toString());
            _markers.add(Marker(
              markerId: MarkerId("2"),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(
                title: 'My Current Location',
              ),
            ));

            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            //----------------------//
            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            final coordinates = Coordinates(value.latitude, value.longitude);
            var address =
                await Geocoder.local.findAddressesFromCoordinates(coordinates);
            var first = address.first.addressLine;
            SharedPreferences _prefs = await SharedPreferences.getInstance();
            _prefs.setString('address', first);
            Fluttertoast.showToast(msg: "$first");
            setState(() {});
          });
        },
        label: const Text('Locate Me!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
}

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    TextEditingController startLocation = TextEditingController();
    TextEditingController endLocation = TextEditingController();

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 80),
        height: 200,
        width: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.yellow.withOpacity(0.6)),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 180,
                      child: TextField(
                        controller: startLocation,
                        decoration: InputDecoration(
                            hintText: "Enter Your Location",
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic,
                        size: 30,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 180,
                      child: TextField(
                        controller: endLocation,
                        decoration: InputDecoration(
                            hintText: "Enter Your Destination",
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.mic,
                            size: 30, color: Colors.yellow[600]))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
