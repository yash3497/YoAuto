import 'package:flutter/material.dart';

import 'package:yoauto_task/constants/constant.dart';

import '../../widget/custom_search_bar.dart';

class Locator extends StatelessWidget {
  const Locator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(color: yellow),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchBar(
                color: custGreen,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
