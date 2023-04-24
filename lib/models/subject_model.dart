import 'package:flutter/material.dart';

import 'homework.dart';

class Subject {
  final String subjectID;
  final String nameOfSubject;
  final String professorName;
  final String classroom;
  final Color color;
  final int day;
  final int week;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<Homework> homeworks;

  const Subject(
      {required this.subjectID,
      required this.nameOfSubject,
      required this.professorName,
      required this.classroom,
      required this.color,
      required this.day,
      required this.week,
      required this.startTime,
      required this.endTime,
      required this.homeworks});
}
