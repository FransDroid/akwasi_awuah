import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

class ReusableInlineExample extends StatefulWidget {
  const ReusableInlineExample({Key? key}) : super(key: key);

  @override
  _ReusableInlineExampleState createState() => _ReusableInlineExampleState();
}

class _ReusableInlineExampleState extends State<ReusableInlineExample> {
  BannerAd? _bannerAd;
  bool _bannerAdIsLoaded = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create the ad objects and load ads.
    _bannerAd = BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-1853630939538135/3796963605'
            : 'ca-app-pub-1853630939538135/8188878027',
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('$BannerAd loaded.');
            setState(() {
              _bannerAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        ),
        request: const AdRequest())
      ..load();

  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BannerAd? bannerAd = _bannerAd;
    return Center(
      child: _bannerAdIsLoaded && bannerAd != null ?
      SizedBox(
          child: AdWidget(ad: bannerAd)) : null,
    );
  }
}