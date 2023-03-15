import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:math';
import 'package:kidzworld/utls/custom_appbar.dart';
import 'package:kidzworld/database/gk_questions.dart';

class McqGameScreen extends StatefulWidget {
  static const routeName = 'mcq-game';
  @override
  _McqGameScreenState createState() => _McqGameScreenState();
}

class _McqGameScreenState extends State<McqGameScreen> {
  int score = 0;
  List<Question> questions = question;
  int currentQuestion = Random().nextInt(49);
  bool? isCorrect;
  List<int> usedQuestions = [];

  void checkAnswer(String answer) {
    if (answer == questions[currentQuestion].correctAnswer) {
      setState(() {
        score++;
        isCorrect = true;
      });
    } else {
      setState(() {
        isCorrect = false;
      });
    }
    showResult();
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isCorrect == true
              ? const Text("Correct!")
              : const Text("Incorrect!"),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.pink.shade400;
                    }
                    return Colors.pink.shade100; // default color
                  },
                ),
              ),
              child: const Text("Next"),
              onPressed: () {
                Navigator.of(context).pop();
                nextQuestion();
              },
            )
          ],
        );
      },
    );
  }

  void nextQuestion() {
    if (usedQuestions.length == questions.length || usedQuestions.length == 9) {
      showFinalScore();
    } else {
      int randomQuestion;
      do {
        randomQuestion = Random().nextInt(questions.length);
      } while (usedQuestions.contains(randomQuestion));
      setState(() {
        currentQuestion = randomQuestion;
        usedQuestions.add(randomQuestion);
        isCorrect = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'GK',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(25),
            Text("Score: $score"),
            const Gap(80),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Question ${usedQuestions.length + 1}/10:",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  questions[currentQuestion].question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const Gap(20),
            ...(questions[currentQuestion].answers).map((answer) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    checkAnswer(answer);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    height: 50,
                    width: 250,
                    child: Center(child: Text(answer)),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void showFinalScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text('Result:${score / 10 * 100}%'),
              Text("Right Answers: $score"),
              const Text("Total Questions: 10"),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.pink.shade400;
                    }
                    return Colors.pink.shade100; // default color
                  },
                ),
              ),
              child: const Text("Retry"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => McqGameScreen(),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
