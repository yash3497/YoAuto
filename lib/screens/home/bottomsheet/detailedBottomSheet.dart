// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/database/firebaseDB.dart';
import 'package:yoauto_task/constants/ids.dart';
import 'package:yoauto_task/screens/home/map/navigationScreen.dart';
import 'package:yoauto_task/widget/widget.dart';

import 'widgets/addonsContainer.dart';

class DetailedBottomSheet extends StatefulWidget {
  List<String>? driverPic;
  String? startPlace;
  String? endPlace;
  String? driverName;
  String? rate;
  String? vehicleNumber;
  String? contactNumber;
  String? pin;
  String? time;
  double? distance;
  double? speed;
  double? price;
  DetailedBottomSheet(
      {super.key,
      this.contactNumber,
      this.vehicleNumber,
      this.pin,
      this.time,
      this.driverName,
      this.driverPic,
      this.rate,
      this.distance,
      this.speed});

  @override
  State<DetailedBottomSheet> createState() => _DetailedBottomSheetState();
}

class _DetailedBottomSheetState extends State<DetailedBottomSheet> {
  int otp = 000000;
  //--------Generate-OTP-----------//
  String generateRandomCode() {
    var rng = new Random();
    int code = rng.nextInt(900000) + 100000;
    setState(() {
      otp == code;
    });
    return code.toString();
  }

  @override
  void initState() {
    super.initState();
    generateRandomCode();
    initBannerAd();
  }

  //------------------------------//
  List<String> images = [
    "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202210/auto_rickshaw_1200x768.jpeg?VersionId=gkYnc4iTwrpIXtX9yhzxw9yZG0BUpzXL&size=690:388",
    "https://images.csmonitor.com/csm/2014/11/RTR4DV1T.jpg?alias=standard_900x600"
  ];
  String price = "XXXX";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        height: context.screenHeight / 2,
        width: context.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(widget.driverName ?? "Driver Name"),
                subtitle: Text(widget.rate ?? "Subtitle"),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                ),
                trailing: Container(
                  height: 40,
                  width: 120,
                  color: Colors.amber,
                  child: Center(
                    child: Text(
                      widget.vehicleNumber ?? "IN010101",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
              //----------Call-Option-----------//
              Container(
                height: 50,
                width: width / 1.1,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.call,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.contactNumber ?? "+XX XXXXXXXXXX",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            "CALL",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //---------Pin----------------//
              Padding(
                padding: EdgeInsets.only(left: 140, right: 140),
                child: Chip(
                  label: Row(
                    children: [
                      Text(
                        "Pin : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "284196",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //---------Duration-Details------------//
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Distance of auto from you is ",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                TextSpan(
                    text: "0",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                TextSpan(
                    text: " minutes",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ])),
              //-------Photos--------//
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 220,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.driverPic?.length ?? images.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        widget.driverPic?[index] ??
                                            images[index]))),
                          ),
                        );
                      })),
                ),
              ),
              //------Distance-Details----------//
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "You are travelling ",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                TextSpan(
                    text: widget.distance != null
                        ? widget.distance.toString()
                        : "0",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                TextSpan(
                    text: " km",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ])),
              //-------Options----------//
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Complimentary",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AddonContainer(
                Icon: Icon(
                  Icons.watch_rounded,
                  color: Colors.green,
                ),
                title: "Chocolate",
              ),
              AddonContainer(
                Icon: Icon(
                  Icons.dashboard,
                  color: Colors.green,
                ),
                title: "Chewingum",
              ),
              AddonContainer(
                Icon: Icon(
                  Icons.book,
                  color: Colors.green,
                ),
                title: "Magzine",
              ),
              //-------Options-||----------//
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Addiotional Facility",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AddonContainer(
                Icon: Icon(
                  Icons.wifi,
                  color: Colors.green,
                ),
                title: "Wifi",
              ),
              AddonContainer(
                Icon: Icon(
                  Icons.power,
                  color: Colors.green,
                ),
                title: "Charging",
              ),
              AddonContainer(
                Icon: Icon(
                  Icons.water_rounded,
                  color: Colors.green,
                ),
                title: "Water Bottle",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Total : ",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    widget.price.toString() ?? price,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    " Rs",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ).p(18),
              CustomBtn(
                text: "Start Ride",
                onPressed: () {
                  Get.to(NavigationScreen());
                  // FirebaseDB().bookRide(
                  //     200,
                  //     otp,
                  //     'driverID',
                  //     00.00,
                  //     00.00,
                  //     00.00,
                  //     00.00,
                  //     12.3,
                  //     2,
                  //     'On The Way',
                  //     ' widget.startPlace',
                  //     'widget.endPlace',
                  //     'Cash',
                  //     false,
                  //     false,
                  //     true,
                  //     true,
                  //     true,
                  //     false);
                },
              ),
              //------Banner-Ad------//
              isAdLoaded
                  ? SizedBox(
                      height: bannerAd?.size.height.toDouble(),
                      width: bannerAd?.size.width.toDouble(),
                      child: AdWidget(ad: bannerAd!),
                    ).p(12)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  //-----Ads-Mob-Configs----//
  BannerAd? bannerAd;
  bool isAdLoaded = false;

  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: bannerAdUnitID,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print(error);
          },
        ),
        request: AdRequest());
    //----Load-Ads----//
    bannerAd?.load();
  }
}
