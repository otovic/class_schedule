import 'package:classschedule_app/Screens/choose_language.dart';
import 'package:classschedule_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './Blocs/ScheduleBloc/schedule_bloc.dart';
import './Blocs/SettingsBloc/settings_bloc.dart';

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
  ScheduleBloc scheduleBloc = ScheduleBloc();
  ScheduleApp();

  @override
  Widget build(BuildContext context) {
    return AppView(this.settingsBloc, this.scheduleBloc);
  }
}

class AppView extends StatefulWidget {
  SettingsBloc settingBloc;
  ScheduleBloc scheduleBloc;
  AppView(this.settingBloc, this.scheduleBloc, {Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState(settingBloc, this.scheduleBloc);
}

class _AppViewState extends State<AppView> {
  SettingsBloc settingsBloc;
  ScheduleBloc scheduleBloc;

  _AppViewState(this.settingsBloc, this.scheduleBloc);

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
      child: Builder(
        builder: (context) {
          return BlocBuilder(
            bloc: this.settingsBloc,
            builder: (BuildContext context, SettingsState state) {
              if (state.status == loadStatus.firstLoad) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<SettingsBloc>.value(value: this.settingsBloc),
                    BlocProvider<ScheduleBloc>.value(value: this.scheduleBloc)
                  ],
                  child: MainScreen(),
                );
              }

              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            },
          );
        },
      ),
    );
  }
}
