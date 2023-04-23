import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/wallet/pass/buyPass.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController amount = TextEditingController();
  //-----Razor-Pay-------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: context.screenHeight / 3,
              width: context.screenWidth,
              color: const Color.fromRGBO(255, 203, 32, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "₹0",
                    style: TextStyle(
                        color: Color.fromRGBO(1, 120, 13, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 46),
                  ),
                  Text("Wallet Money",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 26))
                      .pOnly(top: 20)
                ],
              ).pOnly(top: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: context.screenHeight / 12,
              width: context.screenWidth / 1.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      spreadRadius: 5,
                      blurRadius: 5)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Add Wallet Money",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle_rounded,
                        color: Color.fromRGBO(1, 120, 13, 1),
                        size: 40,
                      )).pOnly(bottom: 8)
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: context.screenHeight / 12,
              width: context.screenWidth / 1.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      spreadRadius: 5,
                      blurRadius: 5)
                ],
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Link UPI",
                    style: TextStyle(
                        color: Color.fromRGBO(1, 120, 13, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //------Banner-Ad------//
            // isAdLoaded
            //     ? SizedBox(
            //         height: bannerAd?.size.height.toDouble(),
            //         width: bannerAd?.size.width.toDouble(),
            //         child: AdWidget(ad: bannerAd!),
            //       ).p(12)
            //     : SizedBox(
            //         height: 150,
            //       ),
            Container(
                height: context.screenHeight / 12,
                width: context.screenWidth / 1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        spreadRadius: 5,
                        blurRadius: 5)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "View Wallet Transaction",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.history,
                          color: Color.fromRGBO(1, 120, 13, 1),
                          size: 40,
                        )).pOnly(bottom: 8)
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            //-----My Passes---------//
            InkWell(
              onTap: () => Get.to(BuyPassScreen()),
              child: Container(
                height: context.screenHeight / 12,
                width: context.screenWidth / 1.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Pass-Banner.gif')),
                    color: Colors.amber.shade300,
                    border: Border.all(color: Vx.green700, width: 3),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // //-----Ads-Mob-Configs----//
  // BannerAd? bannerAd;
  // bool isAdLoaded = false;

  // initBannerAd() {
  //   bannerAd = BannerAd(
  //       size: AdSize.largeBanner,
  //       adUnitId: bannerAdUnitId2,
  //       listener: BannerAdListener(
  //         onAdLoaded: (ad) {
  //           setState(() {
  //             isAdLoaded = true;
  //           });
  //         },
  //         onAdFailedToLoad: (ad, error) {
  //           ad.dispose();
  //           print(error);
  //         },
  //       ),
  //       request: AdRequest());
  //   //----Load-Ads----//
  //   bannerAd?.load();
  // }

  //-------------------------------//

}
