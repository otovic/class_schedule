import 'package:classschedule_app/Services/date_service.dart';
import 'package:flutter/material.dart';

class WeekDayBox extends StatelessWidget {
  final DateTime date;
  final String lang;
  const WeekDayBox(this.date, this.lang, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("PETAR"),
      child: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.shortestSide * 0.2,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.shortestSide * 0.15,
            height: MediaQuery.of(context).size.shortestSide * 0.15,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateService.getWeekDayFromNum(date.weekday, this.lang)
                      .toString()
                      .substring(0, 3),
                  style: TextStyle(
                    fontSize: 8,
                  ),
                ),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateService.getMonthFromNum(date.month, this.lang)
                      .toString()
                      .substring(0, 3),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
