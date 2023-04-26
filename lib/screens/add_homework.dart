import 'package:classschedule_app/Blocs/ScheduleBloc/schedule_bloc.dart';
import 'package:classschedule_app/constants/words.dart';
import 'package:classschedule_app/models/homework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/SettingsBloc/settings_bloc.dart';
import '../Widgets/input_dialog.dart';
import '../constants/themes.dart';

class AddHomework extends StatefulWidget {
  final String subjectname;
  final String subjectID;
  const AddHomework(
      {required this.subjectname, required this.subjectID, super.key});

  @override
  State<AddHomework> createState() =>
      _AddHomeworkState(subName: subjectname, subjectId: subjectID);
}

class _AddHomeworkState extends State<AddHomework> {
  final String subName;
  final String subjectId;
  DateTime date = DateTime.now();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  void _showSnackBar(BuildContext context, String warning) {
    var snackBar = SnackBar(
      content: Text(warning),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _AddHomeworkState({required this.subName, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return BlocBuilder(
          bloc: scheduleBloc,
          builder: (BuildContext context, ScheduleState schState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  addHomework[state.settings.langID]!,
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                iconTheme: state.settings.theme == 'light'
                    ? iconThemeDark
                    : iconThemeLight,
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${subject[state.settings.langID]!}: $subName",
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputDialog(
                        placeholderText: homeworkName[state.settings.langID]!,
                        controller: name,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputDialog(
                        maxLines: 10,
                        placeholderText: homeworkDesc[state.settings.langID]!,
                        controller: description,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.white12,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${dueDate[state.settings.langID]!}:",
                              style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2030),
                                );

                                setState(() {
                                  date = picked!;
                                });
                              },
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.6,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  "${date.day} - ${date.month} - ${date.year}",
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            20,
                                  ),
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
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (name.text == "") {
                              _showSnackBar(context,
                                  fillAllFields[state.settings.langID]!);
                              return;
                            }
                            if (date.difference(DateTime.now()) <
                                Duration(seconds: 0)) {
                              _showSnackBar(context,
                                  fillCorrectDate[state.settings.langID]!);
                              return;
                            }

                            scheduleBloc.add(
                              AddNewHomework(
                                Homework(
                                    id: subjectId,
                                    name: name.text,
                                    description: description.text,
                                    dueDate: date,
                                    completed: false),
                              ),
                            );

                            Navigator.of(context).pop();
                          },
                          child: Text(addWord[state.settings.langID]!),
                        ),
                      )
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
