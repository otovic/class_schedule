import 'package:classschedule_app/Screens/choose_language.dart';
import 'package:classschedule_app/Screens/loader.dart';
import 'package:classschedule_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './Blocs/ScheduleBloc/schedule_bloc.dart';
import './Blocs/SettingsBloc/settings_bloc.dart';
import './constants/themes.dart';

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
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: LoaderScreen(),
      ),
    ),
  );
}
