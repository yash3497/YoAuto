import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/text.dart';

class CustomTxtBtn extends StatelessWidget {
  const CustomTxtBtn(
      {super.key,
      required this.text,
      required this.icon,
      this.onTap,
      this.style});
  final String text;
  final IconData icon;
  final TextStyle? style;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
            ),
            2.widthBox,
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: style ?? text4style,
            ),
          ],
        ),
      ).pOnly(left: 5, right: 5, top: 13, bottom: 13),
    ).pOnly(left: 30, right: 30);
  }
}
