import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kidzworld/games/MathGamePage.dart';
import 'package:kidzworld/games/McqquestionGame.dart';
import 'package:kidzworld/games/MemoryMatchGame.dart';
import 'package:kidzworld/games/PuzzalGame.dart';
import 'package:kidzworld/games/WordsGamePage.dart';
import 'package:kidzworld/learn/DigitsPage.dart';
import 'package:kidzworld/learn/DrawingPage.dart';
import 'package:kidzworld/learn/LettersPage.dart';
import 'package:kidzworld/learn/customLetterPage.dart';
import 'package:kidzworld/pages/aboutpage.dart';
import 'package:kidzworld/pages/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'KidzWorld',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.lightGreen,
//         textTheme: GoogleFonts.latoTextTheme(
//           Theme.of(context).textTheme,
//         ),
//       ),
//       home: const MyHomePage(),
//       routes: {
//         AboutPage.routeName: (ctx) => AboutPage(),
//         '/math-game-page': (context) => MathGame(),
//         '/words-game-page': (context) => WordsGamePage(),
//         '/digits': (context) => DigitsPage(),
//         '/custom-letters': (context) => CustomLetterPage(),
//         '/letters': (context) => LettersPage(),
//         '/drawings': (context) => DrawingPage(),
//         '/puzzal-game-page': (context) => PuzzalGame(),
//         '/memory-match-game': (context) => MemoryMatchGame(),
//         '/mcq-game': (context) => McqGameScreen(),
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show an "Are you sure?" dialog box and return the user's choice
        final bool? shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Yes'),
              ),
            ],
          ),
        );
        // Return whether the user chose to exit or not
        return shouldPop ?? false;
      },
      child: MaterialApp(
        title: 'KidzWorld',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const MyHomePage(),
        routes: {
          AboutPage.routeName: (ctx) => AboutPage(),
          '/math-game-page': (context) => MathGame(),
          '/words-game-page': (context) => WordsGamePage(),
          '/digits': (context) => DigitsPage(),
          '/custom-letters': (context) => CustomLetterPage(),
          '/letters': (context) => LettersPage(),
          '/drawings': (context) => DrawingPage(),
          '/puzzal-game-page': (context) => PuzzalGame(),
          '/memory-match-game': (context) => MemoryMatchGame(),
          '/mcq-game': (context) => McqGameScreen(),
        },
      ),
    );
  }
}

