import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/utls/ads_banner.dart';
import 'dart:math';

import 'package:kidzworld/utls/custom_appbar.dart';
import 'package:kidzworld/utls/custom_choice.dart';

class MathGame extends StatefulWidget {
  static const routeName = '/math-game-page';
  @override
  _MathGameState createState() => _MathGameState();
}

class _MathGameState extends State<MathGame> {
  Random _random = Random();
  int _num1 = 1;
  int _num2 = 1;
  String _operation = '+';
  int _answer = 2;
  List<int> _choices = [];
  int _score = 0;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    // Generate two random numbers between 1 and 10
    _num1 = _random.nextInt(20) + 1;
    _num2 = _random.nextInt(10) + 1;

    // Randomly choose an operation to perform on the numbers
    int operationIndex = _random.nextInt(4);
    switch (operationIndex) {
      case 0:
        _operation = '+';
        _answer = _num1 + _num2;
        break;
      case 1:
        _operation = '-';
        _answer = _num1 - _num2;
        break;
      case 2:
        _operation = '*';
        _answer = _num1 * _num2;
        break;
      case 3:
        _operation = '/';
        _answer = _num1 ~/ _num2;
        break;
    }

    // Generate three possible answer choices, one of which is correct
    _choices.clear();
    _choices.add(_answer);
    while (_choices.length < 3) {
      int choice = _random.nextInt(20) + 1;
      if (!_choices.contains(choice)) {
        _choices.add(choice);
      }
    }
    _choices.shuffle();
  }

  void checkAnswer(int choice) {
    if (choice == _answer) {
      // Correct answer, increase score and generate a new question
      setState(() {
        _score += 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.lightGreen,
          content: Text('Correct answer.'),
          duration: Duration(milliseconds: 400),
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          generateQuestion();
        });
      });
    } else {
      // Wrong answer, decrease score and show a snackbar
      setState(() {
        _score = _score > 0 ? _score - 1 : 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade400,
          content: const Text('Wrong answer, try again.'),
          duration: const Duration(milliseconds: 400),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Math Game',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            const Gap(100),
            Text(
              'Score: $_score',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Gap(100),
            Column(
              children: [
                Text(
                  '$_num1 $_operation $_num2 = ?',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Gap(25),
                Text('Choose your answer:',
                    style: Theme.of(context).textTheme.headlineSmall),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomChoice(
                      function: () => checkAnswer(_choices[0]),
                      height: 80,
                      width: 80,
                      text: Text(
                        '${_choices[0]}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    const Gap(16),
                    CustomChoice(
                      function: () => checkAnswer(_choices[1]),
                      height: 80,
                      width: 80,
                      text: Text(
                        '${_choices[1]}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    const Gap(16),
                    CustomChoice(
                      function: () => checkAnswer(_choices[2]),
                      height: 80,
                      width: 80,
                      text: Text(
                        '${_choices[2]}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(16),
            TextButton(
              onPressed: () {
                setState(() {
                  generateQuestion();
                });
              },
              child: const Text('Skip this question'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyAds(),
    );
  }
}