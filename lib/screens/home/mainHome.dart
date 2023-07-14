// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/database/firebaseDB.dart';
import 'package:yoauto_task/backend/services/locationServices.dart';
import 'package:yoauto_task/constants/ids.dart';
import 'package:yoauto_task/screens/CurrentRide/current_ride.dart';
import 'package:yoauto_task/screens/home/book_ride_screen.dart';
import 'package:yoauto_task/screens/home/loadingScreen.dart';
import 'package:yoauto_task/screens/home/map/functions/locationFunctions.dart';
import 'package:yoauto_task/screens/home/map/google_map_screen.dart';
import 'package:yoauto_task/screens/home/map/mapScreen.dart';
import 'package:yoauto_task/screens/home/map/mapmyindia.dart';
import 'package:yoauto_task/screens/home/search/pickupSearchScreen.dart';
import 'package:yoauto_task/screens/wallet/wallet_screen.dart';
import 'package:yoauto_task/widget/custom_drawer_btn.dart';
import 'package:yoauto_task/widget/driver_searching_dialog.dart';
import 'package:yoauto_task/widget/widget.dart';

import '../../constants/constant.dart';
import '../../widget/custom_drawerScreen.dart';
import 'bottomsheet/detailedBottomSheet.dart';
import 'findRide/rideFinderScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool reserved = true;
  bool sharing = false;

  String? currentAddress = LocationFunctions.currentAddress;

  _recursion() async {
    if (pickupLat != 0.0 && pickupLng != 0.0) {
      setState(() {});
      return;
    }
    return _recursion();
  }

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
      body: FutureBuilder(
          future: _recursion(),
          builder: (context, _) {
            return GoogleMapScreen(
              plat: pickupLat,
              plng: pickupLng,
              dlat: dropLat,
              dlng: dropLng,
            );
          }),

      bottomSheet: Container(
        height: context.screenHeight / 2.8,
        width: context.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        child: StatefulBuilder(builder: (context, setState2) {
          return Column(
            children: [
              // SearchMapPlaceWidget(apiKey: placeAPI),
              Text(
                "Where To?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ).pOnly(top: 20),
              Container(
                height: 50,
                width: context.screenWidth / 1.2,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                    onTap: (() {
                      showSearch(
                          context: context, delegate: PickupSearchDelegate());
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                        ).p(12),
                        Expanded(
                          child: Center(
                            child: Text(
                              currentAddress ??
                                  pickupLocation ??
                                  "Add a pickup location",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    )),
              ).pOnly(top: 20),
              //------------Destination-Location-------------//
              Container(
                  height: 50,
                  width: context.screenWidth / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: (() {
                      showSearch(
                          context: context, delegate: DropSearchDelegate());
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                        ).p(12),
                        Expanded(
                          child: Center(
                            child: Text(
                              dropLocation ?? "Add a drop location",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).pOnly(top: 30),
              Row(
                children: [
                  Text(
                    'Booking Type :',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Checkbox(
                    value: reserved,
                    onChanged: (value) {
                      setState2(() {
                        reserved = !reserved;
                        sharing = !sharing;
                      });
                    },
                  ),
                  Text(
                    'Reserved',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Checkbox(
                    value: sharing,
                    onChanged: (value) {
                      setState2(() {
                        sharing = !sharing;
                        reserved = !reserved;
                      });
                    },
                  ),
                  Text(
                    'Sharing',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ).pOnly(left: 20, right: 20),
              //------------Destination-Location-------------//
              InkWell(
                onTap: (() async {
                  int amount = await FirebaseDB().fetchAmount(sharing);
                  double distance = LocationServices.fetchDistance(
                      pickupLat, pickupLng, dropLat, dropLng);
                  await FirebaseDB().sendBookingRequest(
                      [pickupLat, pickupLng],
                      [dropLat, dropLng],
                      amount * distance,
                      distance,
                      pickupLocation!,
                      dropLocation!);
                  // Get.to(DriverSearching(),
                  //     transition: Transition.fadeIn,
                  //     duration: Duration(seconds: 1));
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  var reqId = _prefs.getString('reqId');

                  Get.to(RideFinderScreen(reqId: reqId!));
                }),
                child: Container(
                    height: 50,
                    width: context.screenWidth / 1.4,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )).pOnly(top: 0),
              )
            ],
          );
        }),
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {

      // ),
    );
  }
}

class HomeContainer extends StatefulWidget {
  String? address;
  String? destination;
  HomeContainer({Key? key, this.address, this.destination}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    TextEditingController startLocation =
        TextEditingController(text: widget.address);
    TextEditingController endLocation =
        TextEditingController(text: widget.destination);

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
                      child: TextFormField(
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
