// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
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
  BookRideScreen(
      {super.key,
      this.price,
      this.kiloMeter,
      this.pickupLat,
      this.pickupLng,
      this.dropLat,
      this.dropLng});

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

  void initState() {
    MapmyIndiaAccountManager.setMapSDKKey('167140dcd36d6813b79a4d1804928dde');
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
      bottomSheet: DetailedBottomSheet(),
    );
  }
}
