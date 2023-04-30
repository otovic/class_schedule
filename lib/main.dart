import 'package:classschedule_app/screens/choose_language.dart';
import 'package:classschedule_app/screens/loader.dart';
import 'package:classschedule_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/schedule_bloc/schedule_bloc.dart';
import './blocs/settings_bloc/settings_bloc.dart';
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
                '/choose-language': (context) => const ChooseLanguage(),
                '/main-screen': (context) => const MainScreen(),
              },
              theme: state.settings.theme == 'light' ? lightTheme : darkTheme,
              debugShowCheckedModeBanner: false,
              home: const LoaderScreen(),
            );
          }),
    ),
  );
}
