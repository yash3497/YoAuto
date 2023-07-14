// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoauto_task/backend/database/firebaseDB.dart';
import 'package:yoauto_task/constants/constant.dart';
import 'package:yoauto_task/screens/authentication/email_login_page.dart';
import 'package:yoauto_task/screens/authentication/otp_screen.dart';
import 'package:yoauto_task/screens/authentication/phone_login_page.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';
import 'package:yoauto_task/screens/home/map/loactionLoadScreen.dart';

import '../../screens/authentication/register_page.dart';
import '../../screens/home/mainHome.dart';

class AuthManager {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // //------LOgin----------//
  // Future<void> signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     final result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     Fluttertoast.showToast(msg: "Welcome");

  //     // User is signed in.
  //     Get.to(MainScreen());
  //   } on FirebaseAuthException catch (e) {
  //     // An error occurred.
  //     Fluttertoast.showToast(
  //         msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
  //   }
  // }

  // //------Register----------//
  // Future<void> createUserWithEmail(String email, String password) async {
  //   try {
  //     final result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     Fluttertoast.showToast(
  //         msg: "Account Created Suceffuly, Please Login to Continue");

  //     // User is signed in.
  //     Get.to(LoginScreen());
  //   } on FirebaseAuthException catch (e) {
  //     // An error occurred.
  //     Fluttertoast.showToast(
  //         msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
  //   }
  // }

  //---------Login with phone no-------------//
  Future<bool> isPhoneNumberRegistered(String phoneNumber) async {
    try {
      final confirmationResult =
          await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
      return confirmationResult != null;
    } catch (e) {
      print('Error checking phone number registration: $e');
      return false;
    }
  }

  void checkPhoneNumberRegistration(String phoneNumber) async {
    bool isRegistered = await isPhoneNumberRegistered(phoneNumber);
    if (isRegistered) {
      Fluttertoast.showToast(msg: 'Phone number is already registered.');
    } else {
      Fluttertoast.showToast(msg: 'Phone number is not registered.');
    }
  }

  Future<void> signInWithPhone(String phone) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      await users
          .where('phone', isEqualTo: phone)
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
                VerificationId.login = verificationId;
              },
              codeAutoRetrievalTimeout: (String verificationId) {});

          String? uid = _auth.currentUser?.uid.toString();

          //------Save user details locally--------//
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          _prefs.setString('phone', phone);

          Get.to(
              OtpAuthScreen(
                phone: phone,
                isLogin: true,
              ),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 800));
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
            VerificationId.register = verificationId;
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
          verificationId: VerificationId.login, smsCode: otp);
      UserCredential userCred = await _auth.signInWithCredential(credential);
      User? user = userCred.user;
      if (user != null && userCred.additionalUserInfo!.isNewUser) {
        FirebaseDB().saveNewUserInfo(name, phone);
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => const LocationLoadScreen())));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  //---------Verify OTP-------------//
  Future<void> RegistrationVerifyOTP(
      String otp, BuildContext context, String name, String phone) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: VerificationId.register, smsCode: otp);
      UserCredential userCred = await _auth.signInWithCredential(credential);
      User? user = userCred.user;
      if (user != null && userCred.additionalUserInfo!.isNewUser) {
        FirebaseDB().saveNewUserInfo(name, phone);
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => const LocationLoadScreen())));
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
