import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class PassQRScreen extends StatefulWidget {
  const PassQRScreen({super.key});

  @override
  State<PassQRScreen> createState() => _PassQRScreenState();
}

class _PassQRScreenState extends State<PassQRScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fluttertoast.showToast(msg: 'Congrats Now You Own The Pass 🎉');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        title: Text("My Pass"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Scan This QR by Driver To Start Your Ride",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ).pOnly(left: 20, right: 20, top: 50),
          Center(
            child: QrImage(
              data: '12345',
              version: QrVersions.auto,
              size: 200,
            ).pOnly(top: 30),
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Icon(Icons.wallet_membership),
            minLeadingWidth: 10,
            subtitle: Text("29 Days & 92KM are Remaining"),
            title: Text(
              "Monthly Pass",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.drive_eta),
            minLeadingWidth: 10,
            subtitle: Text("Used 2 Times Till Now"),
            title: Text(
              "How many times used?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.history),
            minLeadingWidth: 10,
            subtitle: Text("Travelling History"),
            title: Text(
              "Tap to see your travelling history",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
