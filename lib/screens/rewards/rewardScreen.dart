// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';
import 'package:yoauto_task/screens/wallet/adScreen.dart';

import '../../constants/ids.dart';
import '../../widget/custom_tile_card.dart';
import '../home/book_ride_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Rewards",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //--------Reward-Card-----------//
            SizedBox(
              height: 20,
            ),
            Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 10,
              child: Container(
                height: context.height / 2.2,
                width: context.width / 1.1,
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
                    InkWell(
                      onTap: () => Get.to(WalletAdScreen()),
                      child: ListTile(
                        tileColor: Colors.green,
                        leading: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        minLeadingWidth: 10,
                        title: Text(
                          "Watch ads to earn coins",
                          style: TextStyle(fontSize: 18),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ).pOnly(left: 35, top: 40),
                    )
                  ],
                ).pOnly(top: 10),
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
                })),
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
    );
  }

  //-----Ads-Mob-Configs----//
  BannerAd? bannerAd;
  bool isAdLoaded = false;

  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: bannerAdUnitId2,
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

  //-------------------------------//
}
