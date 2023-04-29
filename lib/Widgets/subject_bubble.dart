import 'package:classschedule_app/Services/utility.dart';
import 'package:classschedule_app/screens/add_homework.dart';
import 'package:flutter/material.dart';

import '../models/homework.dart';
import '../models/subject_model.dart';
import '../screens/alter_homework.dart';

class SubjectBubble extends StatelessWidget {
  final Subject subject;
  const SubjectBubble({required this.subject, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: subject.color,
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            SubjectBubbleRow(
              icon: Icons.timer_outlined,
              text: UtilityService.generateTimeText(
                  subject.startTime, subject.endTime),
            ),
            SubjectBubbleRow(
              icon: Icons.subject_outlined,
              text: subject.nameOfSubject,
            ),
            SubjectBubbleRow(
              icon: Icons.person_2_outlined,
              text: subject.professorName,
            ),
            SubjectBubbleRow(
              icon: Icons.door_back_door_outlined,
              text: subject.classroom,
            ),
            SizedBox(
              height: 20,
            ),
            HomeWorkStripe(
              icon: Icons.home_work_outlined,
              subjectName: subject.nameOfSubject,
              subjectID: subject.subjectID,
              homeworks: subject.homeworks,
            )
          ],
        ),
      ),
    );
  }
}

class SubjectBubbleRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const SubjectBubbleRow({required this.icon, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.shortestSide * 1,
      height: 30,
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

class HomeWorkStripe extends StatelessWidget {
  final IconData icon;
  final String subjectName;
  final String subjectID;
  final List<Homework>? homeworks;
  const HomeWorkStripe(
      {required this.icon,
      required this.subjectName,
      required this.subjectID,
      required this.homeworks,
      Key? key})
      : super(key: key);

  List<Widget> _generateWidgets(BuildContext context) {
    List<Widget> list = [];

    list.add(
      Container(
        width: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddHomework(
                  subjectname: subjectName,
                  subjectID: subjectID,
                ),
              ),
            );
          },
          child: Align(
              alignment: Alignment.center,
              child: Text(
                '+',
                style: TextStyle(color: Colors.black),
              )),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.white38),
          ),
        ),
      ),
    );

    homeworks!.forEach(
      (element) {
        if (element.completed == false) {
          list.add(
            SizedBox(
              width: 5,
            ),
          );
          list.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AlterHomework(
                      homework: element,
                      subjectID: subjectID,
                    ),
                  ),
                );
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white38,
                ),
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Text(element.name),
              ),
            ),
          );
        }
      },
    );

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.shortestSide * 1,
      height: 30,
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
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _generateWidgets(context),
            ),
          )
        ],
      ),
    );
  }
}
