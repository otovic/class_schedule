import 'package:classschedule_app/Blocs/ScheduleBloc/schedule_bloc.dart';
import 'package:classschedule_app/constants/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/SettingsBloc/settings_bloc.dart';
import '../Widgets/input_dialog.dart';
import '../constants/themes.dart';

class AddHomework extends StatefulWidget {
  final String subjectname;
  const AddHomework({required this.subjectname, super.key});

  @override
  State<AddHomework> createState() => _AddHomeworkState(subName: subjectname);
}

class _AddHomeworkState extends State<AddHomework> {
  final String subName;
  TextEditingController name = TextEditingController();

  _AddHomeworkState({required this.subName});

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
                      controller: name,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
