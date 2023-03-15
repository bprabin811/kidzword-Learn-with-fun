import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  int itemCount;
  final Function(int) onTap;
  final Color Function(int) color;
  Widget Function(int) child;
  bool istrue;
  int crossAccessCount;
  CustomGrid(
      {super.key,
      required this.itemCount,
      required this.onTap,
      required this.color,
      required this.child,
      required this.istrue,
      required this.crossAccessCount
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          height: 450,
          width: MediaQuery.of(context).size.width >= 450
              ? 400
              : MediaQuery.of(context).size.width,
          child: GridView.builder(
            shrinkWrap: istrue,
            itemCount: itemCount,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAccessCount,
              childAspectRatio: 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTap(index),
                child: Container(
                    decoration: BoxDecoration(
                        color: color(index),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: child(index)),
              );
            },
          ),
        ),
      ),
    );
  }
}
