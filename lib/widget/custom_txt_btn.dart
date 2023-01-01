import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/text.dart';

class CustomTxtBtn extends StatelessWidget {
  const CustomTxtBtn(
      {super.key, required this.text, required this.icon, this.onTap});
  final String text;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        side: BorderSide(
          color: Colors.black,
          width: 3,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
            ),
            2.widthBox,
            Text(
              text,
              style: text4style,
            ),
          ],
        ),
      ).pOnly(left: 5, right: 5, top: 13, bottom: 13),
    ).pOnly(left: 30, right: 30);
  }
}
