import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

final List<String> list = <String>["Week 1", "Week 2"];

class WeekSelector extends StatelessWidget {
  WeekSelector(this.numberOfWeeks, {super.key});

  int numberOfWeeks = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        underline: Container(),
        value: list.first,
        items: list.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}
