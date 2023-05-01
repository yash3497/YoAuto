// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:yoauto_task/functions/distances.dart';
import 'package:yoauto_task/screens/home/map/functions/mapConfigs.dart';
import 'package:yoauto_task/screens/home/map/mapScreen.dart';

import '../../widget/custom_drawerScreen.dart';
import '/widget/widget.dart';

import 'package:velocity_x/velocity_x.dart';

import 'bottomsheet/detailedBottomSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookRideScreen extends StatefulWidget {
  String? reqId;
  double? price;
  double? kiloMeter;
  double? pickupLat;
  double? pickupLng;
  double? dropLat;
  double? dropLng;
  String? driverId;
  double? pin;
  double? time;
  BookRideScreen(
      {super.key,
      this.reqId,
      this.price,
      this.kiloMeter,
      this.pickupLat,
      this.pickupLng,
      this.dropLat,
      this.dropLng,
      this.driverId,
      this.pin,
      this.time});

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _BookRideScreenState extends State<BookRideScreen> {
  MapmyIndiaMapController? mapController;
  Future<void> addPolyline() async {
    Line? line = await mapController?.addLine(LineOptions(geometry: [
      LatLng(widget.pickupLat!, widget.pickupLng!),
      LatLng(widget.dropLat!, widget.dropLng!)
    ], lineColor: "#3bb2d0", lineWidth: 4));
  }

  void initState() {
    MapMyIndiaConfigs();
    addPolyline();

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
      body: MapmyIndiaMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.pickupLat ?? 25.321684, widget.pickupLng ?? 82.987289),
          zoom: 14.0,
        ),
        myLocationEnabled: true,
        trackCameraPosition: true,
        onMapCreated: (map) => {
          mapController = map,
        },
      ),
      bottomSheet: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('drivers')
              .doc(widget.driverId)
              .snapshots(),
          builder: (context, snapshot) {
            var driverName = snapshot.data?['name'];
            var vehicleNumber =
                snapshot.data?['vehicleNumber'] ?? "MH 43 CF 2297";
            var contactNumber =
                snapshot.data?['contactNumber'] ?? "+91 9988667755";
            var driverImage = snapshot.data?['driverImage'] ??
                'https://images.unsplash.com/photo-1609252509102-aa73ff792667?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80';
            return DetailedBottomSheet(
              rideId: widget.reqId,
              vehicleNumber: vehicleNumber,
              driverName: driverName,
              driverPic: [driverImage],
              time: widget.time ?? 1,
              pin: widget.pin.toString(),
            );
          }),
    );
  }
}
