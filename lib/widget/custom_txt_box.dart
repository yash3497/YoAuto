import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/text.dart';

class CustomTextBox extends StatelessWidget {
  CustomTextBox({
    Key? key,
    this.keyboardType,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  final String hintText;
  TextInputType? keyboardType;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        hintStyle: TextStyle(
          color: const Color(0xFF575757),
          fontSize: 25,
          fontFamily: font1,
        ),
      ),
    ).pOnly(left: 30, right: 30);
  }
}
