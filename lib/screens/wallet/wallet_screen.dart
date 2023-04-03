import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

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
      backgroundColor: Colors.white38,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: 428,
              color: const Color.fromRGBO(255, 203, 32, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "₹ XXX",
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
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 75,
              width: 340,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Add Wallet Money",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_circle_rounded,
                          color: Color.fromRGBO(1, 120, 13, 1),
                          size: 40,
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 75,
              width: 340,
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
              margin: const EdgeInsets.only(bottom: 30),
              height: 75,
              width: 340,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "View Wallet Transaction",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.history,
                          color: Color.fromRGBO(1, 120, 13, 1),
                          size: 40,
                        )),
                  )
                ],
              ).pOnly(top: 30),
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
