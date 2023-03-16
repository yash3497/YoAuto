import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';
import 'package:yoauto_task/constants/constant.dart';

import '/widget/widget.dart';
import 'only_phone_login.dart';
import 'otp_screen.dart';
import 'register_page.dart';

class OnlyPhoneRegister extends StatefulWidget {
  const OnlyPhoneRegister({super.key});
  static String verify = "";

  @override
  State<OnlyPhoneRegister> createState() => _OnlyPhoneRegisterState();
}

class _OnlyPhoneRegisterState extends State<OnlyPhoneRegister> {
  //controller
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 90,
            left: MediaQuery.of(context).size.width * 0.3,
            child: Image.asset(
              'assets/icons/logo.png',
              width: 160,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Join Us".text.size(35).bold.shadow(1, 1, 2, Colors.white).make(),
                  10.heightBox,
                  "With Just Phone Number".text.size(30).white.semiBold.shadow(1, 2, 3, Colors.black).make(),
                   50.heightBox,

                  CustomPhoneBox(controller: phoneController),
                  50.heightBox,
                  CustomBtn(
                    text: 'Register',
                    onPressed: () {
                      if (phoneController.text.isEmpty ||
                          phoneController.text.length < 10) {
                        Fluttertoast.showToast(
                            msg: "Please Enter Valid Phone No.");
                      } else {
                        AuthManager()
                            .signInWithPhone("+91" + phoneController.text);
                        Get.to(OtpScreen(number: phoneController.text),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 800));
                      }
                    },
                  ),
                  50.heightBox,
                  TextButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      "Already have an account? Login",
                      style: text2style(),
                    ),
                    onPressed: () {
                      Get.to(OnlyPhoneLogin());
                    },
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
