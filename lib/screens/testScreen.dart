import 'package:flutter/material.dart';
import 'package:yoauto_task/constants/constant.dart';

import '../widget/widget.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            CustomSearchBar(
              color: custGreen,
            ),
            SizedBox(
              height: 20,
            ),
            CustomSearchBar(
              color: yellow,
            ),
          ],
        ),
      ),
    );
  }
}
