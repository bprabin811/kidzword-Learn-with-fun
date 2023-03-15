import 'package:flutter/material.dart';
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
import 'package:kidzworld/pages/settings.dart';
import 'package:kidzworld/pages/feedbackpage.dart';
import 'package:google_fonts/google_fonts.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        // StoriesPage.routeName: (ctx) =>  StoriesPage(),
        AboutPage.routeName: (ctx) => AboutPage(),
        SettingsPage.routeName: (ctx) => SettingsPage(),
        '/math-game-page': (context) => MathGame(),
        '/words-game-page': (context)=> WordsGamePage(),
        '/digits': (context) => DigitsPage(),
        '/custom-letters': (context) => CustomLetterPage(),
        '/letters': (context) => LettersPage(),
        '/drawings': (context) => DrawingPage(),
        '/feedback-page': (context) => FeedbackPage(),
        '/puzzal-game-page':(context) => PuzzalGame(),
        '/memory-match-game': (context) => MemoryMatchGame(),
        '/mcq-game': (context) => McqGameScreen(),

      },
    );
  }
}
