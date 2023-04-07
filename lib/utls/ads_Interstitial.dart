import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyInterstitialAd extends StatefulWidget {
  const MyInterstitialAd({Key? key}) : super(key: key);

  @override
  _MyInterstitialAdState createState() => _MyInterstitialAdState();
}

class _MyInterstitialAdState extends State<MyInterstitialAd> {
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;
  final String _adUnitId ='ca-app-pub-3940256099942544/1033173712'; // replace with your own ad unit ID
  // final String _adUnitId ='ca-app-pub-4520713668416571/6083161574'; 
  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdReady) {
      _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          Navigator.pushNamed(context, '/about-page');
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          print('InterstitialAd failed to show: $error');
          Navigator.pushNamed(context, '/about-page');
        },
      );
      _interstitialAd.show();
      _isInterstitialAdReady = false;
      _loadInterstitialAd();
    } else {
      print('Interstitial ad is not ready yet.');
      Navigator.pushNamed(context, '/about-page');
    }
  }


  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showInterstitialAd();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.info,
              size: 40,
              color: Colors.teal.shade400,
              shadows: const [
                BoxShadow(
                  color: Colors.yellow,
                  blurRadius: 20,
                  offset: Offset(5, 5),
                )
              ],
            ),
            Text(
              'About',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.teal.shade400,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
