// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoauto_task/constants/constant.dart';

import 'package:yoauto_task/screens/home/map/mapScreen.dart';

import '../../widget/custom_drawerScreen.dart';
import '/widget/widget.dart';

import 'package:velocity_x/velocity_x.dart';

import 'bottomsheet/detailedBottomSheet.dart';

class BookRideScreen extends StatefulWidget {
  double? price;
  double? kiloMeter;
  double? pickupLat;
  double? pickupLng;
  double? dropLat;
  double? dropLng;
  String? driverID;

  BookRideScreen(
      {super.key,
      this.price,
      this.kiloMeter,
      this.pickupLat,
      this.pickupLng,
      this.dropLat,
      this.dropLng,
      this.driverID});

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _BookRideScreenState extends State<BookRideScreen> {
  Marker? liveMarker;

  void _updateMarker(LatLng latLng) {
    setState(() {
      liveMarker = Marker(
        markerId: MarkerId('live_location'),
        position: latLng,
      );
    });
  }

  var time;
  var speed;
  var distance;

  calculateTime() {
    if (speed != null || distance != null) {
      setState(() {
        time = distance ~/ speed;
        time = time.toString();
      });
      print(time);
    }
  }

  //--------Get-Driver-ID-------//
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void fetchDriverID() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('rideRequest')
        .doc(documentID)
        .get();

    if (snapshot.exists) {
      dynamic specificValue = snapshot.get('driverId');

      driverID = specificValue;

      print('Specific Value: $specificValue');
    }
  }

  late String pin;

  retrieveOtp() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('rideRequest')
        .doc(documentID)
        .get();

    if (snapshot.exists) {
      dynamic specificValue = snapshot.get('pin');
      setState(() {
        pin = specificValue;
      });
      print('Specific Value: $specificValue');
    }
  }

  @override
  void initState() {
    retrieveOtp();
    fetchDriverID();
    calculateTime();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //----------------Day-Night-Checker-----------------//
    // Get the current time
    DateTime now = DateTime.now();

// Define the start and end times for day and night
    final startDayTime = TimeOfDay(hour: 6, minute: 0);
    final endDayTime = TimeOfDay(hour: 18, minute: 0);

// Convert the current time to a TimeOfDay object
    TimeOfDay currentTime = TimeOfDay.fromDateTime(now);

// Convert the start and end times to DateTime objects
    DateTime startDateTime = DateTime(
        now.year, now.month, now.day, startDayTime.hour, startDayTime.minute);
    DateTime endDateTime = DateTime(
        now.year, now.month, now.day, endDayTime.hour, endDayTime.minute);

// Convert the current time to a DateTime object
    DateTime currentDateTime = DateTime(
        now.year, now.month, now.day, currentTime.hour, currentTime.minute);

// Check if the current time is within the day time range
    bool isDayTime = currentDateTime.isAfter(startDateTime) &&
        currentDateTime.isBefore(endDateTime);

// Set the price based on whether it's day or night
    double price = isDayTime ? 6.0 : 10.0;

    //-------------------------------------------------//
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new))),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.question_mark))),
          )
        ],
      ),
      drawer: Drawer(
        elevation: 30,
        child: CustomDrawerScreen(),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.pickupLat ?? 25.321684, widget.pickupLng ?? 82.987289),
          zoom: 14.0,
        ),
        myLocationEnabled: true,
        onMapCreated: (map) => {},
      ),
      bottomSheet: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('drivers')
              .doc(driverID)
              .snapshots(),
          builder: (context, snapshot) {
            var driverPic = snapshot.data?['documents'][0]['driverPhoto'];
            var firstName = snapshot.data?['personalDetails'][0]['firstName'];
            var lastName = snapshot.data?['personalDetails'][0]['lastName'];
            var phone = snapshot.data?['phone'];

            // var phoneNumber = snapshot.data?['phoneNumber'];
            if (snapshot.hasData) {
              return DetailedBottomSheet(
                pin: pin,
                contactNumber: phone,
                driverPic: [driverPic],
                driverName: firstName + " " + lastName,
              );
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
