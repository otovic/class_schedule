import 'package:classschedule_app/Services/date_service.dart';
import 'package:classschedule_app/Services/utility.dart';
import 'package:flutter/material.dart';

import '../constants/words.dart';

class ClassWeekInput extends StatefulWidget {
  ClassWeekInput(
      {required this.lang,
      required this.dayNum,
      required this.setStartTime,
      required this.setEndTime,
      this.startTime = const TimeOfDay(hour: 00, minute: 00),
      this.endTime = const TimeOfDay(hour: 00, minute: 00),
      Key? key})
      : super(key: key);
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  final String lang;
  final int dayNum;
  final Function setStartTime;
  final Function setEndTime;

  @override
  State<ClassWeekInput> createState() =>
      _ClassWeekInputState(setStartTime, setEndTime,
          startTime: startTime, endTime: endTime);
}

class _ClassWeekInputState extends State<ClassWeekInput> {
  _ClassWeekInputState(this.setStartTime, this.setEndTime,
      {this.startTime = const TimeOfDay(hour: 00, minute: 00),
      this.endTime = const TimeOfDay(hour: 00, minute: 00)}) {
    print(startTime);
  }

  TimeOfDay startTime;
  TimeOfDay endTime;
  late final Function setStartTime;
  late final Function setEndTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              "${DateService.getWeekDayFromNum(widget.dayNum, widget.lang)!}:",
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.shortestSide * 0.3,
            height: 50,
            child: GestureDetector(
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                setStartTime(selectedTime);

                setState(() {
                  startTime = selectedTime!;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    UtilityService.formatTime(startTime.hour),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Text(
                    UtilityService.formatTime(startTime.minute),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
                      color: Theme.of(context).backgroundColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.shortestSide * 0.07,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              to[widget.lang]!,
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).backgroundColor),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.shortestSide * 0.25,
            height: 50,
            child: GestureDetector(
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                setEndTime(selectedTime);

                setState(() {
                  endTime = selectedTime!;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    UtilityService.formatTime(endTime.hour),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Text(
                    UtilityService.formatTime(endTime.minute),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
                      color: Theme.of(context).backgroundColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
