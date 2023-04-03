import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        'rides': [{}]
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something was wrong!");
    }
  }
}
