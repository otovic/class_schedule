import 'package:classschedule_app/Blocs/ScheduleBloc/schedule_bloc.dart';
import 'package:classschedule_app/Blocs/SettingsBloc/settings_bloc.dart';
import 'package:classschedule_app/models/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/class_input_week.dart';
import '../Widgets/input_dialog.dart';
import '../constants/themes.dart';
import '../constants/words.dart';
import 'color_picker.dart';

class AlterSubject extends StatefulWidget {
  const AlterSubject({required this.subject, Key? key}) : super(key: key);
  final Subject subject;

  @override
  State<AlterSubject> createState() => _AlterSubjectState(subject: subject);
}

class _AlterSubjectState extends State<AlterSubject> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController professorController = TextEditingController();
  TextEditingController classroomController = TextEditingController();
  Color colorr = const Color.fromRGBO(0, 123, 255, 1);
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  final Subject subject;

  _AlterSubjectState({required this.subject}) {
    _setInitialValues();
  }

  void _setInitialValues() {
    idController.text = subject.subjectID;
    nameController.text = subject.nameOfSubject;
    professorController.text = subject.professorName;
    classroomController.text = subject.classroom;
    startTime = subject.startTime;
    endTime = subject.endTime;
    colorr = subject.color;
  }

  void _setStartTime(TimeOfDay time) {
    setState(() {
      startTime = time;
    });
  }

  void _setEndTime(TimeOfDay time) {
    setState(() {
      endTime = time;
    });
  }

  void setColor(Color newColor) {
    setState(() {
      colorr = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);

    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return BlocBuilder(
          bloc: scheduleBloc,
          builder: (BuildContext context, ScheduleState schState) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text(
                  "${subject.nameOfSubject}",
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
                iconTheme: settingsBloc.state.settings.theme == 'light'
                    ? iconThemeDark
                    : iconThemeLight,
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InputDialog(
                        placeholderText: "${subjectID[state.settings.langID]!}",
                        controller: idController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputDialog(
                        placeholderText:
                            "${subjectName[state.settings.langID]!}",
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputDialog(
                        placeholderText:
                            "${subjectProfessor[state.settings.langID]!}",
                        controller: professorController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputDialog(
                        placeholderText:
                            "${subjectClassroom[state.settings.langID]!}",
                        controller: classroomController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(
                                "${subjectColor[state.settings.langID]!}:",
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.045,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ColorPickerScreen(
                                      selectColor: (c) {
                                        setColor(c);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white38, width: 3),
                                  color: colorr,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          "${classTime[settingsBloc.state.settings.langID]!}:",
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.shortestSide *
                                0.045,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            ClassWeekInput(
                              startTime: subject.startTime,
                              endTime: subject.endTime,
                              dayNum: scheduleBloc.state.currentDate.weekday,
                              lang: settingsBloc.state.settings.langID,
                              setStartTime: (time) {
                                _setStartTime(time);
                              },
                              setEndTime: (time) {
                                _setEndTime(time);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          scheduleBloc.add(
                            ChangeSubject(
                                Subject(
                                  uniqueID: subject.uniqueID,
                                  subjectID: idController.text,
                                  nameOfSubject: nameController.text,
                                  professorName: professorController.text,
                                  classroom: classroomController.text,
                                  color: colorr,
                                  day: subject.day,
                                  week: subject.week,
                                  startTime: startTime,
                                  endTime: endTime,
                                  homeworks: subject.homeworks,
                                ),
                                subject.subjectID),
                          );
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(changeData[
                                settingsBloc.state.settings.langID]!),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          scheduleBloc.add(
                            RemoveSubject(subject.subjectID),
                          );

                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(
                                remove[settingsBloc.state.settings.langID]!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
