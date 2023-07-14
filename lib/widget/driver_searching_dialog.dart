import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yoauto_task/screens/home/book_ride_screen.dart';
import 'package:yoauto_task/screens/home/loadingScreen.dart';

showDriverSearchingDialog(BuildContext context, String reqId) {
  return showDialog(
    context: context,
    builder: (context) {
      return DriverSearching();
    },
  );
}
