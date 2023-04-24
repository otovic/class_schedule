import 'package:classschedule_app/Blocs/ScheduleBloc/schedule_bloc.dart';
import 'package:classschedule_app/Blocs/SettingsBloc/settings_bloc.dart';
import 'package:classschedule_app/Widgets/class_input_week.dart';
import 'package:classschedule_app/Widgets/input_dialog.dart';
import 'package:classschedule_app/constants/words.dart';
import 'package:classschedule_app/models/subject_model.dart';
import 'package:classschedule_app/screens/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/themes.dart';
import '../models/homework.dart';

class AddSubject extends StatefulWidget {
  AddSubject({Key? key}) : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController professorController = TextEditingController();
  TextEditingController classroomController = TextEditingController();
  Color selectedColor = const Color.fromRGBO(0, 123, 255, 1);
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);

  Subject generateSubject(ScheduleState state) {
    return Subject(
        subjectID: idController.text,
        nameOfSubject: nameController.text,
        professorName: professorController.text,
        classroom: classroomController.text,
        color: selectedColor,
        day: state.currentDate.weekday,
        week: state.selectedWeek,
        startTime: startTime,
        endTime: endTime,
        homeworks: <Homework>[]);
  }

  void setCollor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void _setStartTime(TimeOfDay time) {
    startTime = time;
  }

  void _setEndTime(TimeOfDay time) {
    endTime = time;
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);

    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              addSubject[state.settings.langID]!,
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            backgroundColor: Theme.of(context).primaryColor,
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
                    placeholderText: "${subjectName[state.settings.langID]!}",
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
                                  selectColor: (color) {
                                    setCollor(color);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white38, width: 3),
                              color: selectedColor,
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
                        fontSize:
                            MediaQuery.of(context).size.shortestSide * 0.045,
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
                        AddNewSubject(
                          generateSubject(scheduleBloc.state),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.shortestSide * 0.6,
                      height: 50,
                      child: Center(
                        child: Text(
                            addClassT[settingsBloc.state.settings.langID]!),
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
  }
}
