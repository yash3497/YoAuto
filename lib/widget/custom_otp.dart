import 'package:auto/constants/colors.dart';
import 'package:auto/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpBox extends StatelessWidget {
  const CustomOtpBox({super.key, required this.otp});
  final TextEditingController otp;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      textStyle: text1style,
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 60,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        borderWidth: 3,
        activeColor: Colors.black,
        selectedColor: darkGreen,
        selectedFillColor: Colors.white,
        inactiveColor: Colors.black,
        inactiveFillColor: Colors.white,
      ),
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: otp,
      onCompleted: (v) {
        print("Completed");
      },
      appContext: context,
      onChanged: (String value) {},
    );
  }
}
