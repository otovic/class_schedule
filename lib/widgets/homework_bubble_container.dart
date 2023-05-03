import 'package:classschedule_app/constants/words.dart';
import 'package:classschedule_app/models/homework_model.dart';
import 'package:classschedule_app/models/subject_model.dart';
import 'package:flutter/material.dart';

class HomeworkBubble extends StatelessWidget {
  final Subject subject;
  final Homework homework;
  const HomeworkBubble(
      {required this.subject, required this.homework, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: subject.color,
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            HomeworkBubbleRow(
              icon: Icons.subject_outlined,
              text: subject.nameOfSubject,
            ),
            HomeworkBubbleRow(
              icon: Icons.title_outlined,
              text: homework.name,
            ),
            HomeworkBubbleRow(
              icon: Icons.description,
              text: homework.description,
            )
          ],
        ),
      ),
    );
  }
}

class HomeworkBubbleRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const HomeworkBubbleRow({required this.icon, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.shortestSide * 1,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
