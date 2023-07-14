// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CustomTileCard extends StatefulWidget {
  String? title;
  String? imagePath;
  String? value;
  CustomTileCard({Key? key, this.imagePath, this.title, this.value})
      : super(key: key);

  @override
  State<CustomTileCard> createState() => _CustomTileCardState();
}

class _CustomTileCardState extends State<CustomTileCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height / 10,
              width: width / 1.1,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: NetworkImage(widget.imagePath ??
                                "https://i.pinimg.com/originals/d7/25/2a/d7252a71a8943948bb9f438aa6fcd6bf.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Text(
                        widget.title ?? "Amazon Coupons",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width / 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Worth",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.value ?? "100",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Text(
                        "Coins",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
