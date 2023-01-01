import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';
import 'package:yoauto_task/constants/constant.dart';

import '/widget/widget.dart';
import 'otp_screen.dart';
import 'register_page.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});
  static String verify = "";

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  //controller
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                children: [
                  Text(
                    'Welcome Back',
                    style: text1style,
                  ).pOnly(top: 20),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomPhoneBox(controller: phoneController),
                  37.heightBox,
                  CustomBtn(
                    text: 'Continue',
                    onPressed: () {
                      AuthManager()
                          .signInWithPhone("+91" + phoneController.text);
                      Get.to(OtpScreen(number: phoneController.text));
                    },
                  ),
                  50.heightBox,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                      ' OR '.text.textStyle(text3style).make(),
                      const Expanded(
                        child: Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ],
                  ).pOnly(left: 30, right: 30),
                  25.heightBox,
                  CustomTxtBtn(
                    text: "Login with TrueCaller",
                    icon: Icons.phone,
                    onTap: () {},
                  ),
                  90.heightBox,
                  const Divider(
                    color: darkGreen,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      "Don't have an account? Register",
                      style: text2style(),
                    ),
                    onPressed: () {
                      Get.to(RegisterPage());
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
