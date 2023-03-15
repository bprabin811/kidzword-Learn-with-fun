import 'package:flutter/material.dart';
import 'package:kidzworld/learn/SignaturePainter.dart';
import 'package:kidzworld/utls/custom_choice.dart';

class CustomLetterPage extends StatefulWidget {
  @override
  _CustomLetterPageState createState() => _CustomLetterPageState();
}

class _CustomLetterPageState extends State<CustomLetterPage> {
  String _selectedLetter = '';
  final List<List<Offset>> _lines = [];

  // Add a key for the CustomPaint widget
  Key _customPaintKey = UniqueKey();

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Custom Letter'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.pink.shade400,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    // color: Colors.grey[300],
                    border: Border.all(color: Colors.pink.shade400, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      _selectedLetter == '' ? 'क' : _selectedLetter,
                      style: TextStyle(
                          fontSize:  _selectedLetter.length == 1 ? 200.0 : (_selectedLetter.length <= 2 ? 160.0 : 60.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400),
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
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter a letter or digit to draw:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _textEditingController,
                          // maxLength: 36,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25.0),
                          decoration: InputDecoration(
                              hintText: 'क',
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none),
                          onChanged: (text) {
                            setState(() {
                              _selectedLetter = text;
                              _lines.clear();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      CustomChoice(
                          function: () {
                            setState(() {
                              _selectedLetter = _textEditingController.text;
                              _lines.clear();
                            });
                          },
                          text: Text('Draw'),
                          height: 40,
                          width: 150),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
