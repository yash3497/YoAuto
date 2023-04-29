import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

double calculateDistance(lat1, lon1, lat2, lon2, output) {
  var p = 0.017453292519943295;

  var c = math.cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  var dem = 12742 * math.asin(math.sqrt(a));
  print(dem);
  output = dem;
  return 12742 * math.asin(math.sqrt(a));
}

double radians(degrees) {
  return degrees * math.pi / 180;
}

void saveRandomCodeNumberToFirestore() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var reqId = _prefs.getString('reqId');
  int min = 100000;
  int max = 999999;
  math.Random random = new math.Random();
  int randomNumber = min + random.nextInt(max - min);

  print("OTP :" + randomNumber.toString());

  await FirebaseFirestore.instance
      .collection('rideRequest')
      .doc(reqId)
      .update({'pin': randomNumber});
}

calculateTime(distance) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var reqId = _prefs.getString('reqId');
  var time;
  if (distance <= 5.0) {
    time = 5;
    time = time.toString();
    await FirebaseFirestore.instance
        .collection('rideRequest')
        .doc(reqId)
        .update({'time': time});

    print(time);
  }
  if (distance > 10) {
    time = 15;
    time = time.toString();
    await FirebaseFirestore.instance
        .collection('rideRequest')
        .doc(reqId)
        .update({'time': time});

    print("Time : " + time.toString());
  }
}
