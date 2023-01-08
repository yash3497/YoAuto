// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';
import 'package:yoauto_task/constants/constant.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import '../home/book_ride_screen.dart';
import '/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'phone_login_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                children: [
                  Text(
                    'Welcome Back',
                    style: text1style,
                  ).pOnly(top: 20),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextBox(
                      hintText: 'Email',
                      controller: emailController,
                      obscureText: false),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextBox(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: true),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomBtn(
                    text: 'Login',
                    onPressed: () {
                      AuthManager().signInWithEmailAndPassword(
                          emailController.text, passwordController.text);
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
                    text: "Login with Phone number",
                    icon: Icons.phone_android,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    onTap: () {
                      Get.to(PhoneLoginPage());
                    },
                  ),
                  10.heightBox,
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
