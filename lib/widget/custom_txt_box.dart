import 'package:auto/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
