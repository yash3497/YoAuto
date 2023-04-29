import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AudioCallScreen extends StatefulWidget {
  String? driverName;
  String? contactNumber;
  String? driverImage;
  AudioCallScreen(
      {super.key, this.driverName, this.contactNumber, this.driverImage});

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Calling to ${widget.driverName}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: context.screenHeight / 20,
            backgroundImage: NetworkImage(widget.driverImage!),
            backgroundColor: Colors.grey,
          ),
          Text(widget.contactNumber ?? "*********").pOnly(top: 60),
          Container(
            height: context.screenHeight / 16,
            width: context.screenWidth / 3.2,
            decoration: BoxDecoration(
              color: Vx.red700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "END",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
