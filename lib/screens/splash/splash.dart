// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';

import '../authentication/email_login_page.dart';
import '../authentication/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _pageDecider() async {
    if (_auth.currentUser == null) {
      await Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => LoginPage())));
      });
    } else {
      await Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => MainScreen())));
        Fluttertoast.showToast(msg: "Welcome, You already logged In !");
      });
    }
  }

  //------Init-Firebase--------//
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageDecider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/icons/logo.png',
          width: MediaQuery.of(context).size.width * 0.6,
        ).pOnly(right: 20),
      ),
    );
  }
}
