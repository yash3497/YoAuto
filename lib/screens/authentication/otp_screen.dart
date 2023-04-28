import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';
import 'package:yoauto_task/constants/constant.dart';
import 'package:yoauto_task/constants/text.dart';
import '/widget/widget.dart';
import '../BottomBar/master_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.number, required this.name});
  final String number;
  final String name;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  //controller
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Didn't receive OTP?".text.color(hintColor).size(15).make(),
                Text(
                  " Request again",
                  style: text2style(color: green, weight: FontWeight.w600),
                ).onInkTap(() {}),
              ],
            )),
            20.heightBox,
            CustomBtn(
              text: 'Verify & Login',
              onPressed: () {
                AuthManager().verifyOTP(
                    otpController.text, context, widget.name, widget.number);
              },
            ),
            60.heightBox,
          ],
        ).pOnly(top: 50, left: 0, right: 0),
      ),
    );
  }
}
