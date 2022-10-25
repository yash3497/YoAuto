import 'package:auto/screens/authentication/phone_login_page.dart';
import 'package:auto/screens/authentication/register_page.dart';
import '/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:auto/constants/constant.dart';

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
                    onPressed: () {},
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
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneLoginPage()));
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
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
