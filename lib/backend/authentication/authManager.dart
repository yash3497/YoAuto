// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoauto_task/backend/database/firebaseDB.dart';
import 'package:yoauto_task/screens/authentication/email_login_page.dart';
import 'package:yoauto_task/screens/authentication/otp_screen.dart';
import 'package:yoauto_task/screens/authentication/phone_login_page.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';

import '../../screens/authentication/register_page.dart';
import '../../screens/home/mainHome.dart';

class AuthManager {
  FirebaseAuth _auth = FirebaseAuth.instance;

  //------LOgin----------//
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Fluttertoast.showToast(msg: "Welcome");

      // User is signed in.
      Get.to(MainScreen());
    } on FirebaseAuthException catch (e) {
      // An error occurred.
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  //------Register----------//
  Future<void> createUserWithEmail(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Fluttertoast.showToast(
          msg: "Account Created Suceffuly, Please Login to Continue");

      // User is signed in.
      Get.to(LoginPage());
    } on FirebaseAuthException catch (e) {
      // An error occurred.
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  //---------Login with phone no-------------//
  Future<void> signInWithPhone(String phone) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      await users
          .where('phone', isEqualTo: phone.replaceAll("+91", ""))
          .get()
          .then((QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isEmpty) {
          Fluttertoast.showToast(
              msg: "User not found, Please Register to Continue",
              toastLength: Toast.LENGTH_LONG);
          Get.to(
            RegisterPage(),
            transition: Transition.fadeIn,
          );
        } else {
          await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phone,
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, forceResendingToken) {
                PhoneLoginPage.verify = verificationId;
              },
              codeAutoRetrievalTimeout: (String verificationId) {});

          String? uid = _auth.currentUser?.uid.toString();

          //------Save user details locally--------//
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          _prefs.setString('phone', phone);

          Get.to(
              OtpScreen(
                number: phone,
                name: querySnapshot.docs[0]['name'],
              ),
              transition: Transition.fadeIn,
              duration: Duration(milliseconds: 800));
        }
      });

      // User is signed in.
    } on FirebaseAuthException catch (e) {
      // An error occurred.
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  //---------Register with phone no-------------//
  Future<void> signUpWithPhone(String phone) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, forceResendingToken) {
            PhoneLoginPage.verify = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});

      String? uid = _auth.currentUser?.uid.toString();

      //------Save user details locally--------//
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('phone', phone);

      // User is signed in.
    } on FirebaseAuthException catch (e) {
      // An error occurred.
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  //---------Verify OTP-------------//
  Future<void> verifyOTP(
      String otp, BuildContext context, String name, String phone) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: PhoneLoginPage.verify, smsCode: otp);
      UserCredential userCred = await _auth.signInWithCredential(credential);
      User? user = userCred.user;
      if (user != null && userCred.additionalUserInfo!.isNewUser) {
        FirebaseDB().saveNewUserInfo(name, phone);
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => MainScreen())));
      Fluttertoast.showToast(msg: "Welcome to YOAUTO");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  Future<void> updateUserDetails(
      String address, String email, String dob, String gender) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final users = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser?.uid)
        .set({
      "Address": address,
      "Email": email,
      "D.O.B": dob,
      "Gender": gender
    });
  }
}
