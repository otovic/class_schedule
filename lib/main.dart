import 'package:classschedule_app/Screens/choose_language.dart';
import 'package:classschedule_app/Screens/loader.dart';
import 'package:classschedule_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './Blocs/ScheduleBloc/schedule_bloc.dart';
import './Blocs/SettingsBloc/settings_bloc.dart';
import './constants/themes.dart';

void main() {
  final settingsBloc = SettingsBloc();
  final scheduleBloc = ScheduleBloc();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (BuildContext context) => settingsBloc,
        ),
        BlocProvider<ScheduleBloc>(
          create: (BuildContext context) => scheduleBloc,
        ),
      ],
      child: BlocBuilder(
          bloc: settingsBloc,
          buildWhen: (SettingsState previous, SettingsState current) {
            if (previous.settings.theme != current.settings.theme) return true;
            return false;
          },
          builder: (BuildContext context, SettingsState state) {
            return MaterialApp(
              routes: {
                '/choose-language': (context) => ChooseLanguage(),
                '/main-screen': (context) => MainScreen(),
              },
              theme: state.settings.theme == 'light' ? lightTheme : darkTheme,
              debugShowCheckedModeBanner: false,
              home: LoaderScreen(),
            );
          }),
    ),
  );
}
