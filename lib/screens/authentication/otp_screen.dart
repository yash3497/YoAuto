import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';
import 'package:yoauto_task/constants/constant.dart';
import 'package:yoauto_task/constants/text.dart';
import '/widget/widget.dart';
import '../BottomBar/master_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.number});
  final String number;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  //controller
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.arrow_back_rounded,
                  size: 28,
                ).onInkTap(() {
                  Navigator.pop(context);
                }),
                Text(
                  'Verify Phone',
                  style: text5style,
                ),
              ],
            ),
          ).pOnly(left: 30, right: 30),
          40.heightBox,
          Center(
            child: Text(
              'OTP is send to +91 ${widget.number}',
              style: text2style(color: Colors.black),
            ),
          ),
          30.heightBox,
          CustomOtpBox(otp: otpController).pOnly(left: 30, right: 30),
          const Spacer(),
          Center(
            child: Row(
              children: [
                Text(
                  "Didn't receive OTP?",
                  style: text2style(color: hintColor, weight: FontWeight.w400),
                ),
                Text(
                  " Request again",
                  style: text2style(color: green, weight: FontWeight.w600),
                ).onInkTap(() {}),
              ],
            ).pOnly(left: 30, right: 0),
          ),
          20.heightBox,
          CustomBtn(
            text: 'Verify & Login',
            onPressed: () {
              AuthManager().verifyOTP(otpController.text, context);
            },
          ),
          60.heightBox,
        ],
      ).pOnly(top: 50, left: 0, right: 0),
    );
  }
}
