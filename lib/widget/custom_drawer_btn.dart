import 'package:flutter/material.dart';
import 'package:yoauto_task/constants/constant.dart';

import '../constants/shadow.dart';

class CustomDrawerBtn extends StatelessWidget {
  const CustomDrawerBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        Icons.menu,
        size: 30,
        color: custGreen,
      ),
    );
  }
}
