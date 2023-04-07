import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kidzworld/utls/ads_banner.dart';
import 'package:kidzworld/utls/custom_appbar.dart';
import 'package:kidzworld/utls/custom_choice.dart';

class WordsGamePage extends StatefulWidget {
  static const routeName = '/words-game-page';

  @override
  _WordsGamePageState createState() => _WordsGamePageState();
}

class _WordsGamePageState extends State<WordsGamePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Random _random = Random();
  String _category = 'fruits';
  String _word = '';
  String _originalWord = '';
  int _missingIndex = 0;
  List<String> _choices = [];

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    // Select a random category
    _category =
        ['fruits', 'animals', 'body parts', 'vehicles'][_random.nextInt(4)];

    // Select a random word from the category
    List<String> categoryWords;
    switch (_category) {
      case 'fruits':
        categoryWords = ['apple', 'banana', 'orange', 'pear'];
        break;
      case 'animals':
        categoryWords = ['dog', 'cat', 'elephant', 'lion'];
        break;
      case 'body parts':
        categoryWords = ['hand', 'foot', 'eye', 'ear'];
        break;
      case 'colors':
        categoryWords = ['red', 'blue', 'yellow', 'green'];
        break;
      case 'shapes':
        categoryWords = ['circle', 'square', 'triangle', 'rectangle'];
        break;
      case 'food':
        categoryWords = ['pizza', 'burger', 'hotdog', 'spaghetti'];
        break;
      case 'clothing':
        categoryWords = ['shirt', 'pants', 'socks', 'hat'];
        break;
      case 'school supplies':
        categoryWords = ['pencil', 'notebook', 'ruler', 'eraser'];
        break;
      case 'sports':
        categoryWords = ['soccer', 'basketball', 'football', 'tennis'];
        break;
      case 'vehicles':
        categoryWords = ['motorcycle', 'boat', 'helicopter', 'bicycle','plane', 'bus', 'car', 'train'];
        break;
      default:
        categoryWords = ['Computer', 'Mobile', 'Earphone', 'Headphone'];
        break;
    }
    _originalWord = categoryWords[_random.nextInt(categoryWords.length)];
    _word = _originalWord;

    // Randomly select a letter to remove from the word
    _missingIndex = _random.nextInt(_word.length);
    _word = _word.replaceRange(_missingIndex, _missingIndex + 1, '_');

    // Generate three answer choices, one of which is correct
    _choices.clear();
    _choices.add(_originalWord.substring(_missingIndex, _missingIndex + 1));
    while (_choices.length < 3) {
      String choice = String.fromCharCode(_random.nextInt(26) + 97);
      if (choice != _originalWord[_missingIndex] &&
          !_choices.contains(choice)) {
        _choices.add(choice);
      }
      if (_choices.length == 3 && _choices.toSet().length != 3) {
        // If any of the choices are duplicates, start over
        _choices.clear();
        _choices.add(_originalWord.substring(_missingIndex, _missingIndex + 1));
      }
    }
    _choices.shuffle();
    // print(_originalWord[_missingIndex]);
  }

  void checkAnswer(String choice) {
    if (choice == _originalWord[_missingIndex]) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightGreen,
          content: Text('Correct answer.'),
          duration: Duration(milliseconds: 400),
        ),
      );
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          generateQuestion();
        });
      });
    } else {
      // Wrong answer, show a snackbar and let the user retry
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade400,
          content: Text('Wrong answer, try again.'),
          duration: Duration(milliseconds: 400),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Words Game',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Category: $_category',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                'What is the missing letter in this word?',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '$_word'.toUpperCase(),
              style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade800),
            ),
            SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomChoice(
                  function: () => checkAnswer(_choices[0]),
                  text: Text(
                    '${_choices[0]}'.toUpperCase(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  height: 80,
                  width: 80,
                ),
                SizedBox(width: 16.0),
                CustomChoice(
                  function: () => checkAnswer(_choices[1]),
                  text: Text(
                    '${_choices[1]}'.toUpperCase(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  height: 80,
                  width: 80,
                ),
                SizedBox(width: 16.0),
                CustomChoice(
                  function: () => checkAnswer(_choices[2]),
                  text: Text(
                    '${_choices[2]}'.toUpperCase(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  height: 80,
                  width: 80,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                setState(() {
                  generateQuestion();
                });
              },
              child: Text('Skip this question'),
            ),
          ],
        ),
      ),
       bottomNavigationBar: const MyAds(),
    );
  }
}
