import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/utls/ads_Interstitial.dart';
import 'package:kidzworld/utls/ads_banner.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.pink.shade400,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const Image(
                    image: AssetImage('assets/images/playstore.png'),
                    width: 100,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Learn with Fun',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade800,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                'Learn to write and recognize letters and digits, and play fun logical games!',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Gap(20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SelectableText.rich(
                TextSpan(
                  text: 'Email us at ',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'kidzworld095@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: ' for support or feedback.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Copyright © 2023 Pro Win',
                style: TextStyle(fontSize: 16, color: Colors.pink.shade400),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyAds(),
    );
  }
}
