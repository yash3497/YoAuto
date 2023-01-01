import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yoauto_task/screens/authentication/otp_screen.dart';
import 'package:yoauto_task/screens/authentication/phone_login_page.dart';

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
      Get.to(HomeScreenTwo());
    } on FirebaseAuthException catch (e) {
      // An error occurred.
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  //---------Login with phone no-------------//
  Future<void> signInWithPhone(String phone) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, forceResendingToken) {
            PhoneLoginPage.verify = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});

      // User is signed in.
      Get.to(HomeScreenTwo());
    } on FirebaseAuthException catch (e) {
      // An error occurred.
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  //---------Verify OTP-------------//
  Future<void> verifyOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: PhoneLoginPage.verify, smsCode: otp);
    await _auth.signInWithCredential(credential);
  }
}
