import 'package:classschedule_app/blocs/settings_bloc/settings_bloc.dart';
import 'package:classschedule_app/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:classschedule_app/constants/words.dart';
import 'package:classschedule_app/widgets/homework_bubble_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/themes.dart';
import '../models/homework_model.dart';
import '../models/subject_model.dart';
import '../constants/words.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  List<Widget> generateHomeworks(
      BuildContext context, SettingsState settings, ScheduleState state) {
    Map<int, List<Widget>> widgetMap = {};
    List<String> iterated = [];

    for (Subject subject in state.subjects) {
      DateTime date = DateTime.now();

      if (!iterated.contains(subject.nameOfSubject)) {
        iterated.add(subject.nameOfSubject);
        for (Homework homework in subject.homeworks) {
          if (homework.completed == false) {
            if (homework.dueDate.difference(date).inSeconds > 0) {
              print(homework.name);
              int difference = homework.dueDate.difference(date).inDays;
              if (!widgetMap.containsKey(difference)) {
                widgetMap[difference] = <Widget>[
                  Container(
                    width: double.infinity,
                    child: Text(
                      duein[settings.settings.langID]!
                          .replaceAll("|n|", "${difference + 1}"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  HomeworkBubble(
                    subject: subject,
                    homework: homework,
                  )
                ];
              } else {
                widgetMap.update(difference, (value) {
                  value.add(
                    HomeworkBubble(subject: subject, homework: homework),
                  );

                  return value;
                });
              }
            } else {
              if (!widgetMap.containsKey(-1)) {
                widgetMap[-1] = <Widget>[
                  Container(
                    width: double.infinity,
                    child: Text(
                      expired[settings.settings.langID]!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  HomeworkBubble(subject: subject, homework: homework),
                ];
              } else {
                widgetMap.update(-1, (value) {
                  value.add(
                      HomeworkBubble(subject: subject, homework: homework));
                  return value;
                });
              }
            }
          } else {
            if (!widgetMap.containsKey(-2)) {
              widgetMap[-2] = <Widget>[
                Container(
                  width: double.infinity,
                  child: Text(
                    Completed[settings.settings.langID]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                HomeworkBubble(subject: subject, homework: homework)
              ];
            } else {
              widgetMap.update(-2, (value) {
                value.add(HomeworkBubble(subject: subject, homework: homework));
                return value;
              });
            }
          }
        }
      }
    }

    List<int> sortedKeys = [];

    List<Widget> finalList = [];

    widgetMap.keys.forEach((element) {
      sortedKeys.add(element);
    });

    sortedKeys.sort();

    for (int i = 0; i < sortedKeys.length; i++) {
      if (sortedKeys[i] > 0) {
        finalList.add(
          const SizedBox(
            height: 10,
          ),
        );

        widgetMap[sortedKeys[i]]?.forEach(
          (element) {
            finalList.add(element);
            finalList.add(
              const SizedBox(
                height: 5,
              ),
            );
          },
        );

        sortedKeys.removeAt(i);
        i--;
      }
    }

    sortedKeys.forEach((element) {
      finalList.add(
        const SizedBox(
          height: 10,
        ),
      );
      widgetMap[element]?.forEach((element) {
        finalList.add(element);
        finalList.add(
          const SizedBox(
            height: 5,
          ),
        );
      });
    });

    return finalList;
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);

    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState settings) {
        return BlocBuilder(
          bloc: scheduleBloc,
          builder: (BuildContext context, ScheduleState schedule) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text(
                  notifications[settings.settings.langID]!,
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
                iconTheme: settingsBloc.state.settings.theme == 'light'
                    ? iconThemeDark
                    : iconThemeLight,
              ),
              body: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: generateHomeworks(context, settings, schedule),
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
