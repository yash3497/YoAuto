import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoauto_task/constants/constant.dart';
import 'package:yoauto_task/screens/home/map/navigationScreen.dart';

class FirebaseDB {
  //--------User-ID------//
  FirebaseAuth _auth = FirebaseAuth.instance;
  //--------------------//
  Future<void> bookRide(
    double amount,
    int pin,
    String driverID,
    double startLat,
    double startLng,
    double endLat,
    double endLng,
    double kiloMeter,
    double autoDistance,
    String status,
    String pickup,
    String destination,
    String paymentMethod,
    bool chocolate,
    bool chewingum,
    bool magzine,
    bool wifi,
    bool charging,
    bool waterBottle,
  ) async {
    try {
      String? uid = _auth.currentUser?.uid.toString();
      CollectionReference rides =
          FirebaseFirestore.instance.collection('rides');

      //-------Save-Ride-Details----------//
      rides.doc().set({
        'rides': FieldValue.arrayUnion([
          {
            'id': rides.doc().id,
            'uid': uid,
            'driverID': driverID,
            'amount': amount,
            'kiloMeter': kiloMeter,
            'autoDistance': autoDistance,
            'pin': pin,
            'status': status,
            'paymentMethod': paymentMethod,
            'complimentary': [
              {
                'chocolate': chocolate,
                'chewingum': chewingum,
                'magzine': magzine,
              }
            ],
            'additional': [
              {
                'wifi': wifi,
                'charging': charging,
                'waterBottle': waterBottle,
              }
            ],
            'start': {
              'pickup': pickup,
              'latitude': startLat,
              'longitude': startLng,
            },
            'end': {
              'destination': destination,
              'latitude': endLat,
              'longitude': endLng,
            }
          }
        ])
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something has wrong, please try again!");
    }
  }

  //------------Cancel-Ride-------------//

  Future<void> cancelRide() async {
    try {
      String? uid = _auth.currentUser?.uid.toString();
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      users.doc(uid).update({
        'rides': [
          {'status': 'cancelled'}
        ]
      });
    } catch (e) {}
  }

  Future<void> saveNewUserInfo(String name, String phone) async {
    try {
      String? uid = _auth.currentUser?.uid.toString();
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      users.doc(uid).set({
        'name': name,
        'phone': phone,
        "uid": uid,
        'rides': {},
        'liveLocation': {'latitude': '', 'longitude': ''}
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something was wrong!");
    }
  }

  //--------Add-Report--------//
  Future<void> report(String driverID, String issue) async {
    try {
      String? uid = _auth.currentUser?.uid.toString();
      CollectionReference reports =
          FirebaseFirestore.instance.collection('reports');
      reports.doc(uid).set({
        'userID': uid,
        'driverID': driverID,
        'issue': issue,
      });
      CollectionReference notifications =
          FirebaseFirestore.instance.collection('Users');
      notifications.doc(uid).update({
        'notifications': FieldValue.arrayUnion([
          {
            'isOpened': false,
            'msg':
                'Your ride has been cancelled as per your report request *${issue}',
          }
        ]),
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something has wrong, please try again!");
    }
  }

  //---------Send-Booking-Requests------------//
  //--------Add-Report--------//
  Future<void> sendBookingRequest(
    List<double> pickup,
    List<double> drop,
    double amount,
    double distance,
    String pickUpName,
    String dropName,
  ) async {
    try {
      String? uid = _auth.currentUser?.uid.toString();

      CollectionReference req =
          FirebaseFirestore.instance.collection('rideRequest');
//generate a 4 digit pin
      var pin = (1000 + Random().nextInt(9999 - 1000)).toString();
      final DocumentReference documentReference = await req.add({
        'userID': uid,
        'amount': amount,
        'distance': distance,
        'pickupLat': pickup[0],
        'pickupLng': pickup[1],
        'dropLat': drop[0],
        'dropLng': drop[1],
        'from': pickUpName,
        'to': dropName,
        'isApproved': false,
        'driverId': '',
        'isStarted': false,
        'pin': pin,
        'date': DateTime.now(),
      });
      final String documentId = documentReference.id;
      await documentReference.set({'id': documentId}, SetOptions(merge: true));

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('reqId', documentId);
      documentID = documentId;
      print("Document ID : " + documentID!);
    } catch (e) {
      Fluttertoast.showToast(msg: "Something has wrong, please try again!");
    }
  }

  Future<int> fetchAmount(bool isShared) async {
    int amount = 0;
    await FirebaseFirestore.instance
        .collection('Prices')
        .doc('toun22gnJOsFWzTZdE78')
        .get()
        .then((value) {
      String nightShiftDuration = value['nightShiftTime'];
      String startNightTime = nightShiftDuration.split('-')[0];
      String endNightTime = nightShiftDuration.split('-')[1];
      //check current time is in under night time
      DateTime now = DateTime.now();

      String formattedTime = DateFormat.Hm().format(now);
      if (int.parse(formattedTime.split(':')[0]) >=
              int.parse(startNightTime.split(':')[0]) &&
          int.parse(formattedTime.split(':')[0]) <=
              int.parse(endNightTime.split(':')[0])) {
        if (isShared) {
          amount = value['sharingPrice']['night'];
        } else {
          amount = value['bookingPrice']['night'];
        }
      } else {
        if (isShared) {
          amount = value['sharingPrice']['day'];
        } else {
          amount = value['bookingPrice']['day'];
        }
      }
    });
    return amount;
  }

  Future<void> startRide(String rideId) async {
    try {
      String? uid = _auth.currentUser?.uid.toString();

      CollectionReference req =
          FirebaseFirestore.instance.collection('rideRequest');

      await req.doc(rideId).update({'isStarted': true});
      Get.to(NavigationScreen());
    } catch (e) {
      print("Error from Start Ride Function : " + e.toString());
    }
  }

  //-------Send User Location on Every 3 Seconds----------//

  Future<void> updateDriverLiveLocation(
      double lat, double lng, String driverID) async {
    try {
      String? uid = _auth.currentUser?.uid.toString();

      CollectionReference req =
          FirebaseFirestore.instance.collection('drivers');

      req.doc(driverID).update({
        'liveLocation': {'latitude': '', 'longitude': ''}
      });
    } catch (e) {
      print("Error from Start Ride Function : " + e.toString());
    }
  }
}
