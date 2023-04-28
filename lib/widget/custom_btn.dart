import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/constant.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const CustomBtn({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: font1,
              ),
            ),
          ),
        ),
      ),
    ).pOnly(left: 30, right: 30);
  }
}
