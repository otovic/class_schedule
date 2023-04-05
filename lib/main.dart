import 'package:classschedule_app/Screens/choose_language.dart';
import 'package:classschedule_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './SettingsBloc/settings_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScheduleApp(),
    ),
  );
}

class ScheduleApp extends StatelessWidget {
  SettingsBloc settingsBloc = SettingsBloc();
  ScheduleApp();

  @override
  Widget build(BuildContext context) {
    return AppView(this.settingsBloc);
  }
}

class AppView extends StatefulWidget {
  SettingsBloc? settingBloc;
  AppView(this.settingBloc, {Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState(settingBloc);
}

class _AppViewState extends State<AppView> {
  SettingsBloc? settingsBloc;

  _AppViewState(this.settingsBloc);

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: this.settingsBloc,
      listener: (BuildContext context, SettingsState state) {
        if (state.status == loadStatus.loading) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<SettingsBloc>(context),
                child: ChooseLanguage(),
              ),
            ),
          );
        }
      },
      child: Builder(builder: (context) {
        return BlocBuilder(
            bloc: this.settingsBloc,
            builder: (BuildContext context, SettingsState state) {
              if (state.status == loadStatus.firstLoad) {
                return MainScreen(this.settingsBloc);
              }

              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            });
      }),
    );
  }
}
