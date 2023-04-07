import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class MyAds extends StatefulWidget {
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBannerAd();
  }

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnit= "ca-app-pub-3940256099942544/6300978111";
  // var adUnit= "ca-app-pub-4520713668416571/3025011133";
  
  initBannerAd(){
    bannerAd = BannerAd(
      size: AdSize.banner, 
    adUnitId: adUnit, 
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          isAdLoaded=true;
        });
      },
      onAdFailedToLoad: (ad,error){
        ad.dispose();
        print(error);
      }

    ), 
    request: const AdRequest()
    );
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return isAdLoaded?SizedBox(
          height: bannerAd.size.height.toDouble(),
          width: bannerAd.size.width.toDouble(),
          child: AdWidget(ad: bannerAd),
        ):SizedBox();
  }
}

  