import 'package:get/get.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';
import 'package:yoauto_task/constants/constant.dart';
import '/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'email_login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobilenumController = TextEditingController();

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
                    'Welcome',
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
                  CustomTextBox(
                      hintText: 'Mobile Number',
                      controller: mobilenumController,
                      obscureText: false),
                  Spacer(),
                  CustomBtn(
                    text: 'Register',
                    onPressed: () {
                      AuthManager().createUserWithEmail(
                          emailController.text, passwordController.text);
                    },
                  ),
                  30.heightBox,
                  const Divider(
                    color: darkGreen,
                  ),
                  TextButton(
                    child: Text(
                      'Already have an account? Login',
                      style: text2style(),
                    ),
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                  ).pOnly(bottom: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
