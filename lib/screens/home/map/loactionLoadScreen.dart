import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/text.dart';

import '../../../backend/services/locationServices.dart';
import '../mainScreen.dart';

class LocationLoadScreen extends StatefulWidget {
  const LocationLoadScreen({super.key});

  @override
  State<LocationLoadScreen> createState() => _LocationLoadScreenState();
}

class _LocationLoadScreenState extends State<LocationLoadScreen> {
  int currentIndex = 0;
  bool isLoading = true;

  _navigate() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.to(() => const MainScreen());
  }

  @override
  void initState() {
    super.initState();
    LocationServices.checkServiceAndPermission();
    _navigate();
    // Simulate loading delay
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/auto-loading.gif')),
          40.heightBox,
          Text(
            'Getting Your Location.....',
            style: TextStyle(fontSize: 16, color: Colors.amber.shade700),
          )
        ],
      )),
    );
  }
}
