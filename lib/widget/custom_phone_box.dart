import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/text.dart';

import '../constants/colors.dart';

class CustomPhoneBox extends StatelessWidget {
  const CustomPhoneBox({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              right: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              '+91',
              style: text2style(color: Colors.black),
            ),
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Phone Number',
              hintStyle: text2style(color: hintColor),
            ),
          ).pOnly(left: 10),
        ),
      ],
    ).pOnly(left: 30, right: 30);
  }
}
