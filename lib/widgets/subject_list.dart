import 'package:classschedule_app/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:classschedule_app/blocs/settings_bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/subject_model.dart';

class SubjectList extends StatelessWidget {
  final Function exe;
  const SubjectList({required this.exe, Key? key}) : super(key: key);

  List<Widget> _generateSubjects(List<Subject> list) {
    List<String> existingID = [];
    List<Widget> widgetList = [];

    for (Subject subject in list) {
      if (!existingID.contains(subject.subjectID)) {
        existingID.add(subject.subjectID);
        widgetList.add(
          SubjectOption(
            subject: subject,
            exe: exe,
          ),
        );
      }
    }

    return widgetList;
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
              backgroundColor: Colors.transparent,
              body: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.7,
                    height: MediaQuery.of(context).size.longestSide * 0.5,
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.3,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.75,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                  children:
                                      _generateSubjects(schState.subjects)),
                            ),
                          )
                        ],
                      ),
                    ),
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

class SubjectOption extends StatelessWidget {
  final Subject subject;
  final Function exe;
  const SubjectOption({required this.subject, required this.exe, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          exe(subject);
          Navigator.of(context).pop();
        },
        child: Text(
          "${subject.subjectID} - ${subject.nameOfSubject}",
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
