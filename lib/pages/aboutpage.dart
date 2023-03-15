import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('KidzWorld',
                  style: TextStyle(
                      shadows: const <Shadow>[
                        BoxShadow(
                            color: Colors.yellow,
                            blurRadius: 5,
                            offset: Offset(5, 5))
                      ],
                      fontSize: 40,
                      color: Colors.amber.shade800,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Text(
            //     'Email us at kidzworld095@gmail.com for support or feedback.',
            //     style: TextStyle(fontSize: 18),
            //   ),
            // ),
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
    );
  }
}
