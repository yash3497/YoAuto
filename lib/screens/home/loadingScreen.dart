import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingScreen extends StatefulWidget {
  String? msg;
  String? docId;
  LoadingScreen({super.key, this.msg, this.docId});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isApproved = false;
  String? reqId;
  getDocId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var docId = await _prefs.getString('reqId');

    setState(() {
      reqId = docId;
    });
    print(reqId ?? 'null');
  }

  @override
  void initState() {
    getDocId();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rideRequest')
              .doc(reqId)
              .snapshots(),
          builder: (context, snapshot) {
            var isApproved = snapshot.data?['isApproved'] ?? false;
            print(isApproved ?? "error");

            if (isApproved) {
              return Center(
                child: Text(
                    "Your Ride has Approved, Please wait we are appointing a best route to your driver..."),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset('assets/images/autoMarker.png')
                        .pOnly(top: 200)),
                Text(
                  widget.msg ?? "loading please wait...",
                  textAlign: TextAlign.center,
                ).pOnly(top: 30)
              ],
            );
          }),
    );
  }
}
