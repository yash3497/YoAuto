// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'rewardScreen.dart';

class RefrEarnScreen extends StatefulWidget {
  RefrEarnScreen({Key? key}) : super(key: key);

  @override
  State<RefrEarnScreen> createState() => _RefrEarnScreenState();
}

class _RefrEarnScreenState extends State<RefrEarnScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height / 7,
            width: width,
            color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Get.to(RewardScreen());
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 36,
                        )),
                  ),
                  Text(
                    "Refer & Earn",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          //----------Poster--------------------//
          Container(
            height: height / 4,
            width: width,
            color: Color(0xffFFE078),
            child: Center(
              child: Image.asset("assets/images/8244.png"),
            ),
          ),
          //----------Content-----------//
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Invite Friends and get 500 pionts on your Reward wallet",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          //----------Tiles----------//
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: height / 8,
                width: width / 1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.card_giftcard,
                          size: 32,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Invite Freinds to Yoauto",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Invite",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //-----------------------------------------------//
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: height / 8,
                width: width / 1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Referal Code",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: DottedBorder(
                        radius: Radius.circular(12),
                        child: Container(
                          height: 35,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "XXXXXX",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await Clipboard.setData(
                                        ClipboardData(text: "YOAUTO"));
                                    Fluttertoast.showToast(msg: "Copied");
                                  },
                                  icon: Icon(Icons.copy))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          //----------Button-------------//
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Container(
              height: height / 15,
              width: width / 1.1,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 129, 4),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Invite",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
