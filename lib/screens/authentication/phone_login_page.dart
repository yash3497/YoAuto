import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';

import '../../widget/gradButton.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String verify = "";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isCorrect = false;
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            80.heightBox,
            Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Yo',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                      ),
                      children: [
                        TextSpan(
                            text: 'Auto',
                            style: TextStyle(
                              color: Colors.amber.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                            ))
                      ])),
            ),
            //----------SubTitle-------//
            80.heightBox,
            Text(
              'Enter your phone no. to continue',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            40.heightBox,
            TextFormField(
              controller: _phoneController,
              maxLength: 10,
              onChanged: (value) {
                if (value.length == 10) {
                  setState(() {
                    isCorrect = true;
                  });
                } else {
                  setState(() {
                    isCorrect = false;
                  });
                }
              },
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber.shade700)),
                hintText: ' 00000 00000',
                prefixText: '+91 ',
                prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
                suffixIcon: isCorrect
                    ? Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.green.shade700,
                      )
                    : Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.grey.shade300,
                      ),
              ),
            ).pOnly(right: 50, left: 50),
            80.heightBox,
            InkWell(
                onTap: (() {
                  if (isCorrect) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => OtpAuthScreen(
                                  isLogin: true,
                                  phone: _phoneController.text,
                                ))));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please enter correct phone no.')));
                  }
                }),
                child: InkWell(
                  onTap: () {
                    AuthManager()
                        .signInWithPhone('+91${_phoneController.text}');
                  },
                  child: GradButton(
                    isCorrect: isCorrect,
                    enableColors: [
                      Colors.amber.shade500,
                      Colors.green.shade500
                    ],
                    disableColors: [Colors.grey.shade300, Colors.grey.shade200],
                    title: 'Continue',
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
