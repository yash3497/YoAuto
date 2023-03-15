// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder2/geocoder2.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/services/locationServices.dart';
import 'package:yoauto_task/screens/CurrentRide/current_ride.dart';
import 'package:yoauto_task/screens/home/book_ride_screen.dart';
import 'package:yoauto_task/screens/home/map/mapScreen.dart';
import 'package:yoauto_task/screens/home/search/pickupSearchScreen.dart';
import 'package:yoauto_task/screens/wallet/wallet_screen.dart';
import 'package:yoauto_task/widget/custom_drawer_btn.dart';
import 'package:yoauto_task/widget/widget.dart';

import '../../widget/custom_drawerScreen.dart';
import 'bottomsheet/detailedBottomSheet.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? pickupStringValue;
  String? dropStringValue;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  getEnteredLocations() async {
    var prefs = await SharedPreferences.getInstance();
    var pickup = prefs.getString('pickupLocation');
    var drop = prefs.getString('dropLocation');
    setState(() {
      pickupStringValue = pickup;
      dropStringValue = drop;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEnteredLocations();
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
      body: MapScreen(),

      bottomSheet: Container(
        height: context.screenHeight / 2.5,
        width: context.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        child: Column(
          children: [
            Text(
              "Where To?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ).pOnly(top: 30),
            Container(
              height: 60,
              width: context.screenWidth / 1.2,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8)),
              child: TextField(
                autofocus: false,
                onTap: (() {
                  showSearch(
                      context: context, delegate: PickupSearchDelegate());
                }),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.location_pin),
                    hintText: pickupStringValue ?? "Add a pickup location"),
              ).pOnly(top: 5, right: 10),
            ).pOnly(top: 30),
            //------------Destination-Location-------------//
            Container(
              height: 60,
              width: context.screenWidth / 1.2,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8)),
              child: TextField(
                onTap: () {
                  showSearch(context: context, delegate: DropSearchDelegate());
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.pin_drop),
                    hintText: dropStringValue ?? "Enter a drop location"),
              ).pOnly(top: 5, right: 10),
            ).pOnly(top: 30),
            //------------Destination-Location-------------//
            InkWell(
              onTap: (() {
                Get.to(BookRideScreen());
              }),
              child: Container(
                  height: 60,
                  width: context.screenWidth / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "Continue",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )).pOnly(top: 30),
            )
          ],
        ),
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
