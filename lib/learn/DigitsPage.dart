import 'package:flutter/material.dart';
import 'package:kidzworld/learn/SignaturePainter.dart';
import 'package:number_to_words/number_to_words.dart';

class DigitsPage extends StatefulWidget {
  @override
  _DigitsPageState createState() => _DigitsPageState();
}

class _DigitsPageState extends State<DigitsPage> {
  int _selectedDigit = -1;
  final List<List<Offset>> _lines = [];

  // Add a key for the CustomPaint widget
  Key _customPaintKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Digits'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.pink.shade400,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    // color: Colors.grey[300],
                    border: Border.all(color: Colors.pink.shade400,width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            _selectedDigit == -1
                                ? 'one'
                                : NumberToWord().convert('en-in', _selectedDigit).toUpperCase(),
                                textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            _selectedDigit == -1 ? '1' : _selectedDigit.toString(),
                            style: TextStyle(
                                fontSize: 200.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
                      setState(() {
                        RenderBox? referenceBox =
                            context.findRenderObject() as RenderBox?;
                        if (referenceBox != null) {
                          double widthRatio =
                              referenceBox.size.width / context.size!.width;
                          double heightRatio =
                              referenceBox.size.height / context.size!.height;
                          Offset localPosition = Offset(
                            details.localPosition.dx * widthRatio,
                            details.localPosition.dy * heightRatio,
                          );
                          if (_lines.isEmpty || _lines.last.isEmpty) {
                            _lines.add([localPosition]);
                          } else {
                            _lines.last.add(localPosition);
                          }
                        }

                        // Change the key of the CustomPaint widget to force a rebuild
                        _customPaintKey = UniqueKey();
                      });
                    },
                    onPanEnd: (DragEndDetails details) {
                      setState(() {
                        _lines.add([]);

                        // Change the key of the CustomPaint widget to force a rebuild
                        _customPaintKey = UniqueKey();
                      });
                    },
                    child: CustomPaint(
                      key: _customPaintKey, // Use the key here
                      painter: SignaturePainter(_lines),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 10,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  children: List.generate(100, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDigit = index;
                          _lines.clear();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedDigit == index
                              ? Colors.pink.shade400
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            index.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

