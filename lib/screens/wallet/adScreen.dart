import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/ids.dart';
import 'package:yoauto_task/widget/custom_btn.dart';

class WalletAdScreen extends StatefulWidget {
  const WalletAdScreen({super.key});

  @override
  State<WalletAdScreen> createState() => _WalletAdScreenState();
}

class _WalletAdScreenState extends State<WalletAdScreen> {
  //------Test--------//
  InterstitialAd? _interstitialAd;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: fullScreenAdID,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('Ad failed to show: $error');
        ad.dispose();
        _loadInterstitialAd();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }

  //-----Ads-Mob-Configs----//
  BannerAd? bannerAd;
  BannerAd? largeBannerAd;
  bool isAdLoaded = false;

  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.largeBanner,
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

  //--------Large-Banner-Ad------------//
  initLargeBannerAd() {
    largeBannerAd = BannerAd(
        size: AdSize.largeBanner,
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
    largeBannerAd?.load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInterstitialAd();
    initBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: //------Banner-Ad------//
                Text("Earn Coins")),
        body: Column(
          children: [
            isAdLoaded
                ? SizedBox(
                    height: bannerAd?.size.height.toDouble(),
                    width: bannerAd?.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd!),
                  ).p(12)
                : SizedBox(
                    height: 150,
                  ),
            Center(
              child: CustomBtn(
                text: 'Tap Here To Play Ads',
                onPressed: () {
                  _showInterstitialAd();
                },
              ).pOnly(top: 100),
            ),
            isAdLoaded
                ? SizedBox(
                    height: bannerAd?.size.height.toDouble(),
                    width: bannerAd?.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd!),
                  ).p(12)
                : SizedBox(
                    height: 150,
                  ),
          ],
        ));
  }
}
