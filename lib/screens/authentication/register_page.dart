// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';

import '../../widget/gradButton.dart';
import 'otp_screen.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String verify = "";
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isCorrect = false;
  bool isFilled = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
              'Please fill below details to continue ;)',
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
            20.heightBox,
            TextFormField(
              controller: _nameController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    isFilled = true;
                  });
                } else {
                  setState(() {
                    isFilled = false;
                  });
                }
              },
              keyboardType: TextInputType.name,
              autofocus: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber.shade700)),
                hintText: 'Enter your full name',
                prefixIcon: const Icon(Icons.person),
                prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ).pOnly(right: 50, left: 50),
            80.heightBox,
            InkWell(
                onTap: (() async {
                  if (isCorrect && _nameController.text.isNotEmpty) {
                    await AuthManager()
                        .signUpWithPhone('+91' + _phoneController.text);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => OtpAuthScreen(
                                  isLogin: false,
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                ))));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please enter correct phone no.')));
                  }
                }),
                child: GradButton(
                  isCorrect: isCorrect && _nameController.text.isNotEmpty,
                  enableColors: [Colors.amber.shade500, Colors.green.shade500],
                  disableColors: [Colors.grey.shade300, Colors.grey.shade200],
                  title: 'Continue',
                ))
          ],
        )),
      ),
    );
  }
}
