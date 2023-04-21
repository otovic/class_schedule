import 'package:classschedule_app/Services/date_service.dart';
import 'package:classschedule_app/Services/utility.dart';
import 'package:flutter/material.dart';

import '../constants/words.dart';

class ClassWeekInput extends StatefulWidget {
  const ClassWeekInput(
      {required this.lang,
      required this.dayNum,
      required this.setStartTime,
      required this.setEndTime,
      Key? key})
      : super(key: key);
  final String lang;
  final int dayNum;
  final Function setStartTime;
  final Function setEndTime;

  @override
  State<ClassWeekInput> createState() =>
      _ClassWeekInputState(setStartTime, setEndTime);
}

class _ClassWeekInputState extends State<ClassWeekInput> {
  _ClassWeekInputState(this.setStartTime, this.setEndTime);
  TimeOfDay startTime = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay endTime = const TimeOfDay(hour: 00, minute: 00);
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
              style: TextStyle(color: Theme.of(context).backgroundColor),
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
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.07,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.07,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Text(
                    UtilityService.formatTime(startTime.minute),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.07,
                      color: Theme.of(context).backgroundColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.shortestSide * 0.08,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              to[widget.lang]!,
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).backgroundColor),
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
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.07,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.07,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Text(
                    UtilityService.formatTime(endTime.minute),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.07,
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
