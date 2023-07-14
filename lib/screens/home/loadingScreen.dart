import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yoauto_task/screens/home/book_ride_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverHomePage extends StatelessWidget {
  DriverHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DriverSearching();
                  });
            },
            child: Text("Show Dialog")),
      ),
    );
  }
}

class DriverSearching extends StatefulWidget {
  DriverSearching({
    Key? key,
  }) : super(key: key);

  @override
  State<DriverSearching> createState() => _DriverSearchingState();
}

class _DriverSearchingState extends State<DriverSearching> {
  String? reqId;
  getDocId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var docId = _prefs.getString('reqId');

    setState(() {
      reqId = docId;
    });
    print(reqId ?? 'null');
  }

  int _timeRemaining = 10 * 60; // 10 minutes

  String imagePath = "assets/images/search.gif";
  String message = "Looking For Driver In Your Area";

  //--------Timer-&-Navigate-----//
  timerNavi() async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--; // decrement time remaining by 1 second
        } else {
          setState(() {
            imagePath = "assets/images/sademoji.png";
            message = "Sorry, No Driver is available in Your Area Now";
            timer.cancel();
          });

          // stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    timerNavi();
    getDocId();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _timeRemaining ~/ 60;
    int seconds = _timeRemaining % 60;

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rideRequest')
            .doc(reqId)
            .snapshots(),
        builder: (context, snapshot) {
          var isAccepted = snapshot.data?['isApproved'];
          var driverId = snapshot.data?['driverId'];

          if (isAccepted == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookRideScreen(
                            driverID: driverId,
                          )));
            });
          }
          return AlertDialog(
            titlePadding: EdgeInsets.fromLTRB(50, 0, 50, 50),
            icon: Image.asset(
              imagePath,
              height: 120,
              width: 120,
            ), // networkIssue
            title: Column(
              children: [
                Text(
                  message,
                  style: TextStyle(fontSize: 20, color: Colors.green[900]),
                ),
                Text(
                  "$minutes:${seconds.toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 30, color: Colors.red[800]),
                ),
              ],
            ),
          );
        });
  }
}
