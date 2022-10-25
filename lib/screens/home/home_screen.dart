import 'package:flutter/material.dart';

import '/widget/widget.dart';

import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomDrawerBtn(),
              const CustomBellBtn(),
            ],
          ),
        ],
      ).pOnly(top: 40, left: 20, right: 20),
    );
  }
}
