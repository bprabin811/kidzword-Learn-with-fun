import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/utls/custom_appbar.dart';

class FeedbackPage extends StatefulWidget {
  static const routeName = '/feedback-page';

  const FeedbackPage({super.key});
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Send Feedback',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Gap(25),
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none),
                ),
              ),
              const Gap(25),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              const Gap(25),
              Container(
                height: 250,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _feedbackController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      hintText: 'Feedback',
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none),
                ),
              ),
              const Gap(25),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink.shade100),
                ),
                onPressed: () {
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final feedback = _feedbackController.text;
                  if (name.isEmpty || email.isEmpty || feedback.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Alert'),
                        content: const Text('Do not leave form blank.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Feedback Sent'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: $name'),
                            Text('Email: $email'),
                            Text('Feedback: $feedback'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _nameController.clear();
                              _emailController.clear();
                              _feedbackController.clear();
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}