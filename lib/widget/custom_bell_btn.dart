// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoauto_task/constants/constant.dart';

import '../constants/shadow.dart';
import 'payment_status_popup.dart';

class CustomBellBtn extends StatelessWidget {
  const CustomBellBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomPopups.paymentStatusPopup(context);
      },
      child: Container(
        width: 45,
        height: 50,
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  customShadow(),
                ],
              ),
              child: const Icon(
                CupertinoIcons.bell_fill,
                size: 30,
                color: custGreen,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: const Color(0xFFDC0000),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
