// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/custom_tile_card.dart';
import '../home/home_screen.dart';

class RewardScreen extends StatefulWidget {
  RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  //------Data------//
  List<String> titles = ["Amazon Coupons", "Ajio Coupons", "Flipkart Coupons"];
  List<String> values = ["100", "90", "150"];
  List<String> imagePaths = [
    "https://i.pinimg.com/originals/d7/25/2a/d7252a71a8943948bb9f438aa6fcd6bf.jpg",
    "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/624fb09845965c000171e03c/picture",
    "https://sightsinplus.nyc3.digitaloceanspaces.com/sightsinplus/wp-content/uploads/2020/05/19074016/flipkart-logo-detail-icon.jpeg",
  ];
  int coins = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                            Get.to(HomeScreen());
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 36,
                          )),
                    ),
                    Text(
                      "Rewards",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            //--------Reward-Card-----------//
            SizedBox(
              height: 20,
            ),
            Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 10,
              child: Container(
                height: height / 3.5,
                width: width / 1.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "You Have",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                    ),
                    //-------------Coins-Counter-------------------//
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "$coins",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 64),
                      ),
                    ),
                    //--------------------//
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Coins",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //--------Title--------//
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Coupons",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ),
            //---------Tiles---------//
            ListView.builder(
                shrinkWrap: true,
                itemCount: titles.length,
                itemBuilder: ((context, index) {
                  return CustomTileCard(
                    title: titles[index],
                    value: values[index],
                    imagePath: imagePaths[index],
                  );
                }))
          ],
        ),
      ),
    );
  }
}
