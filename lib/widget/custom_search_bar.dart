import 'package:auto/constants/constant.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Color color;
  const CustomSearchBar({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color,
              ),
            ),
            SizedBox(
              width: 228,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter the Destination',
                ).copyWith(
                  border: InputBorder.none,
                ),
                style: text2style(
                  color: Colors.black,
                  weight: FontWeight.w400,
                ),
              ),
            ),
            Icon(
              Icons.mic,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
