import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/text.dart';
import 'package:yoauto_task/screens/home/book_ride_screen.dart';

import '../../../backend/services/locationServices.dart';
import '../mainScreen.dart';

class RideFinderScreen extends StatefulWidget {
  String reqId;
  RideFinderScreen({super.key, required this.reqId});

  @override
  State<RideFinderScreen> createState() => _RideFinderScreenState();
}

class _RideFinderScreenState extends State<RideFinderScreen> {
  int currentIndex = 0;
  bool isLoading = true;

  late Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('rideRequest')
        .doc(widget.reqId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: StreamBuilder<DocumentSnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return CircularProgressIndicator();
            }

            final bool isAccepted = snapshot.data!.get('isApproved') ??
                false; // Default value is false

            if (isAccepted) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BookRideScreen()),
                );
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/images/auto-loading.gif')),
                40.heightBox,
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FadeAnimatedText('Finding Your Location...',
                        duration: const Duration(milliseconds: 600),
                        textStyle: TextStyle(
                            fontSize: 16, color: Colors.amber.shade700)),
                    FadeAnimatedText('Locating Nearby Drivers...',
                        duration: const Duration(milliseconds: 600),
                        textStyle: TextStyle(
                            fontSize: 16, color: Colors.green.shade700)),
                    FadeAnimatedText('Searching for Available Vehicles...',
                        duration: const Duration(milliseconds: 600),
                        textStyle: TextStyle(
                            fontSize: 16, color: Colors.amber.shade700)),
                    FadeAnimatedText('Getting the Best Route for You...',
                        duration: const Duration(milliseconds: 600),
                        textStyle: TextStyle(
                            fontSize: 16, color: Colors.green.shade700)),
                    FadeAnimatedText('Preparing Your Ride...',
                        duration: const Duration(milliseconds: 600),
                        textStyle: TextStyle(
                            fontSize: 16, color: Colors.amber.shade700))
                  ],
                )
              ],
            );
          },
        )));
  }
}
