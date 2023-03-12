// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoauto_task/screens/authentication/email_login_page.dart';
import 'package:yoauto_task/screens/authentication/otp_screen.dart';
import 'package:yoauto_task/screens/authentication/phone_login_page.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';

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
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, forceResendingToken) {
            PhoneLoginPage.verify = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});

      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      String? uid = _auth.currentUser?.uid.toString();
      users.add({"phoneNo": phone, "uid": uid});

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
  Future<void> verifyOTP(String otp, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: PhoneLoginPage.verify, smsCode: otp);
      await _auth.signInWithCredential(credential);
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


  //---------Google Signing-------------//

  Future <User?> signInWithGoogle (context) async{

    try{

      // trigger the Authentication dialog

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser != null){
        // obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        // create new Credential
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
        );
        //once signed in return the user data to firebase
        UserCredential userCredential = await _auth.signInWithCredential(credential);

        return userCredential.user;
      }
    }catch(e){
      Fluttertoast.showToast(
          msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }


  }


}
