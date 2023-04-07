import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kidzworld/utls/ads_Interstitial.dart';
import 'package:kidzworld/utls/ads_banner.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: const Image(
                            image: AssetImage('assets/images/playstore.png'),width: 100,)),
                          const Gap(20),
                        Text(
                          'Learn with Fun',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade800,
                          ),
                        ),
                        const Gap(20)
                      ],
                    ),
                  ],
                )),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Learn',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade800,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 100,
              color: Colors.pink.shade400,
            ),
            SizedBox(
              // color: Colors.pink.shade100,
              height: 350,
              width: MediaQuery.of(context).size.width >= 450
                  ? 400
                  : MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    buildOptionContainer(context, 'Digits', '/digits',
                        FontAwesomeIcons.one, Colors.cyan.shade800),
                    buildOptionContainer(context, 'Letters', '/letters',
                        FontAwesomeIcons.a, Colors.green.shade400),
                    buildOptionContainer(
                        context,
                        'Custom Letter',
                        '/custom-letters',
                        FontAwesomeIcons.pencil,
                        Colors.yellow.shade800),
                    buildOptionContainer(context, 'Drawing', '/drawings',
                        Icons.draw, Colors.red.shade800),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Play',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade800),
              ),
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 100,
              color: Colors.pink.shade400,
            ),
            SizedBox(
              height: 350,
              // color: Colors.pink.shade100,
              width: MediaQuery.of(context).size.width >= 450
                  ? 400
                  : MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  crossAxisCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildOptionContainer(
                        context,
                        'Math Game',
                        '/math-game-page',
                        Icons.calculate,
                        Colors.blue.shade400),
                    buildOptionContainer(
                        context,
                        'Words Game',
                        '/words-game-page',
                        FontAwesomeIcons.puzzlePiece,
                        Colors.red.shade400),
                    buildOptionContainer(
                        context,
                        'Puzzal Game',
                        '/puzzal-game-page',
                        Icons.move_up,
                        Colors.purple.shade400),
                    buildOptionContainer(
                        context,
                        'Memory Game',
                        '/memory-match-game',
                        Icons.memory,
                        Colors.teal.shade400),
                    buildOptionContainer(context, 'GK', '/mcq-game',
                        FontAwesomeIcons.question, Colors.green.shade400),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'About us',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade800),
              ),
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 100,
              color: Colors.pink.shade400,
            ),
            SizedBox(
              height: 200,
              // color: Colors.pink.shade100,
              width: MediaQuery.of(context).size.width >= 450
                  ? 400
                  : MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  crossAxisCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // buildOptionContainer(context, 'About', '/about-page',
                        // Icons.info, Colors.teal.shade400),

                    MyInterstitialAd(),
                    
                  ],
                ),
              ),
            ),
            const Gap(20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(child: MyAds()),
            ),
            const Gap(20)
          ],
        ),
      ),
    );
  }

  Widget buildOptionContainer(BuildContext context, String label,
      String routeName, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
              shadows: const [
                BoxShadow(
                  color: Colors.yellow,
                  blurRadius: 20,
                  offset: Offset(5, 5),
                )
              ],
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
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
