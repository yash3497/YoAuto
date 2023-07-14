import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';

import '../../widget/gradButton.dart';

import 'phone_login_page.dart';

class OtpAuthScreen extends StatefulWidget {
  String phone;
  String? name;
  bool isLogin = false;
  OtpAuthScreen(
      {super.key, required this.phone, required this.isLogin, this.name});

  @override
  State<OtpAuthScreen> createState() => _OtpAuthScreenState();
}

class _OtpAuthScreenState extends State<OtpAuthScreen> {
  OtpTimerButtonController controller = OtpTimerButtonController();
  bool isCorrect = false;
  String? otp;

  _requestOtp() {
    controller.loading();
    Future.delayed(const Duration(seconds: 2), () {
      controller.startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            100.heightBox,
            const Text(
              'OTP Verification',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            5.heightBox,
            RichText(
              text: TextSpan(
                  text: 'OTP has sent to : ',
                  style: TextStyle(color: Colors.grey.shade800),
                  children: [
                    TextSpan(
                      text: widget.phone,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
            40.heightBox,
            OtpTextField(
              margin: const EdgeInsets.only(right: 8.0, left: 5.0),
              borderColor: Colors.amber.shade700,
              enabledBorderColor: Colors.amber.shade700,
              focusedBorderColor: Colors.green.shade700,
              fillColor: Colors.amber.shade700,
              fieldWidth: 45.0,
              numberOfFields: 6,
              showFieldAsBox: true,
              onSubmit: (value) {
                if (value.length == 6) {
                  setState(() {
                    otp = value;
                    isCorrect = true;
                  });
                } else {
                  setState(() {
                    isCorrect = false;
                  });
                }
              },
            ),
            20.heightBox,
            OtpTimerButton(
              buttonType: ButtonType.text_button,
              textColor: Colors.black,
              backgroundColor: Colors.black,
              loadingIndicatorColor: Colors.amber.shade700,
              controller: controller,
              onPressed: () => _requestOtp(),
              text: const Text('Resend OTP'),
              duration: 30,
            ),
            20.heightBox,
            InkWell(
              onTap: () {
                widget.isLogin
                    ? AuthManager().verifyOTP(
                        otp ?? '000000', context, 'Unknown', widget.phone)
                    : AuthManager().RegistrationVerifyOTP(otp ?? '000000',
                        context, widget.name ?? 'Unknown', widget.phone);
              },
              child: GradButton(
                isCorrect: isCorrect,
                enableColors: [Colors.amber.shade500, Colors.green.shade500],
                disableColors: [Colors.grey.shade300, Colors.grey.shade200],
                title: 'Continue',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Center(
            child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => LoginScreen())));
                },
                child: Text('wrong number?'))),
      ),
    );
  }
}
