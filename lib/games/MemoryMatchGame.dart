import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/utls/ads_banner.dart';
import 'package:kidzworld/utls/custom_appbar.dart';
import 'package:kidzworld/utls/custom_choice.dart';
import 'package:kidzworld/utls/custum_grid.dart';

class MemoryMatchGame extends StatefulWidget {
  static const routeName = '/memory-match-game';
  @override
  _MemoryMatchGameState createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<int> _items = [];
  List<int> _pickedItems = [];
  int _selectedCount = 0;
  int _firstSelectedIndex = -1;
  int _secondSelectedIndex = -1;
  bool _gameOver = false;
  Timer? _timer = null;
  int _elapsedSeconds = 0;
  int crossAccessCount = 4;

  void _generateElements(int elementCount) {
    setState(() {
      _items = List.generate(
          elementCount, (index) => index % (elementCount ~/ 2) + 1)
        ..shuffle();
      _pickedItems = List.filled(elementCount, 0);
      _selectedCount = 0;
      _firstSelectedIndex = -1;
      _secondSelectedIndex = -1;
      _gameOver = false;
      _elapsedSeconds = 0;
      _timer?.cancel();
      _startTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    _generateElements(16);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _restart() {
    _generateElements(_items.length);
  }

  void _handleItemTap(int index) {
    if (_pickedItems[index] == 0 && !_gameOver) {
      setState(() {
        _pickedItems[index] = _items[index];
        _selectedCount++;
        if (_selectedCount == 1) {
          _firstSelectedIndex = index;
        } else if (_selectedCount == 2) {
          _secondSelectedIndex = index;
          if (_firstSelectedIndex != -1 && _secondSelectedIndex != -1) {
            if (_pickedItems[_firstSelectedIndex] ==
                _pickedItems[_secondSelectedIndex]) {
              _pickedItems[_firstSelectedIndex] = -1;
              _pickedItems[_secondSelectedIndex] = -1;
              if (_pickedItems.every((item) => item == -1)) {
                _gameOver = true;
                _timer?.cancel();

                // Show congratulatory dialog box
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Congratulations!',
                        style: TextStyle(color: Colors.green),
                      ),
                      content: Text(
                          'You completed the game in $_elapsedSeconds seconds.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _restart();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            } else {
              Timer(Duration(milliseconds: 500), () {
                setState(() {
                  for (int i = 0; i < _pickedItems.length; i++) {
                    if (_pickedItems[i] > 0 && _pickedItems[i] != -1) {
                      _pickedItems[i] = 0;
                    }
                  }
                  _firstSelectedIndex = -1;
                  _secondSelectedIndex = -1;
                });
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Please select only two grid items at a time.'),
              backgroundColor: Colors.red.shade400,
            ));
          }
          _selectedCount = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Match Same Digit',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Gap(100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomChoice(
                    function: () {
                      _generateElements(16);
                      crossAccessCount = 4;
                    },
                    text: Text('Easy'),
                    height: 40,
                    width: 80),
                    const Gap(20),
                    CustomChoice(
                    function: () {
                      _generateElements(24);
                      crossAccessCount = 5;
                    },
                    text: Text('Medium'),
                    height: 40,
                    width: 80),
                    const Gap(20),
                    CustomChoice(
                    function: () {
                      _generateElements(36);
                      crossAccessCount = 6;
                    },
                    text: Text('Hard'),
                    height: 40,
                    width: 80),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Time: $_elapsedSeconds seconds',
                style: TextStyle(fontSize: 20, color: Colors.pink.shade800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: CustomGrid(
                  crossAccessCount: crossAccessCount,
                  istrue: true,
                  itemCount: _items.length,
                  onTap: (index) {
                    _handleItemTap(index);
                  },
                  color: (index) => _pickedItems[index] == -1
                      ? Colors.pink.shade400
                      : _pickedItems[index] == 0
                          ? Colors.pink.shade100
                          : Colors.white,
                  child: (index) => Center(
                    child: _pickedItems[index] == 0
                        ? null
                        : _pickedItems[index] == -1
                            ? Icon(Icons
                                .check) // Show close icon for unmatched items
                            : Text(
                                _pickedItems[index].toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: CustomChoice(
                function: () => _restart(),
                text: Text(
                  'Restart',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                height: 50,
                width: 200,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyAds(),
    );
  }
}
