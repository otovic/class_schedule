import 'package:classschedule_app/Screens/choose_language.dart';
import 'package:classschedule_app/Screens/loader.dart';
import 'package:classschedule_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './Blocs/ScheduleBloc/schedule_bloc.dart';
import './Blocs/SettingsBloc/settings_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (BuildContext context) => SettingsBloc(),
        ),
        BlocProvider<ScheduleBloc>(
          create: (BuildContext context) => ScheduleBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/choose-language': (context) => ChooseLanguage(),
          '/main-screen': (context) => MainScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: LoaderScreen(),
      ),
    ),
  );
}

class ScheduleApp extends StatefulWidget {
  ScheduleApp();

  @override
  State<ScheduleApp> createState() => _ScheduleAppState();
}

class _ScheduleAppState extends State<ScheduleApp> {
  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);

    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState settingsState) {
        if (settingsState.status == loadStatus.firstLoad) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, '/choose-language');
          });
        }

        if (settingsState.status == loadStatus.firstLoad2) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, '/main-screen');
          });
        }

        return Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      },
    );
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
    return Builder(
      builder: (context) {
        return BlocBuilder(
          bloc: this.settingsBloc,
          builder: (BuildContext context, SettingsState settingsState) {
            return BlocBuilder(
              bloc: this.scheduleBloc,
              builder: (BuildContext context, ScheduleState state) {
                if (settingsState.status == loadStatus.firstLoad) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<SettingsBloc>.value(
                          value: this.settingsBloc),
                      BlocProvider<ScheduleBloc>.value(value: this.scheduleBloc)
                    ],
                    child: ChooseLanguage(),
                  );
                }

                if (settingsState.status == loadStatus.firstLoad2) {
                  print("KOKOKOKO");
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<SettingsBloc>.value(
                          value: this.settingsBloc),
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
        );
      },
    );
  }
}
