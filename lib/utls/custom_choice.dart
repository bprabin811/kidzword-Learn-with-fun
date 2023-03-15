import 'package:flutter/material.dart';

class CustomChoice extends StatelessWidget {
  void Function()? function;
  Widget text;
  // String text;
  double height;
  double width;
  CustomChoice({super.key, required this.function,required this.text,required this.height,required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.pink.shade100,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Center(
              child: text)),
    );
  }
}