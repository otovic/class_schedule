import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final Color color;
  const ColorBox({required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.shortestSide * 0.15,
      height: MediaQuery.of(context).size.shortestSide * 0.15,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white38, width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color),
      ),
    );
  }
}
