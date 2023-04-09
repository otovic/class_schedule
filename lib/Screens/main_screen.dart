import 'package:classschedule_app/Blocs/ScheduleBloc/schedule_bloc.dart';
import 'package:classschedule_app/Screens/choose_language.dart';
import 'package:classschedule_app/Widgets/day_selector_banner.dart';
import 'package:classschedule_app/Widgets/week_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/SettingsBloc/settings_bloc.dart';
import '../Services/date_service.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Future<void> _checkIsFirstLoad(
      SettingsBloc bloc, BuildContext context) async {
    if (bloc.state.status == loadStatus.firstLoad) {
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ChooseLanguage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final scheduleBloc = BlocProvider.of<ScheduleBloc>(context);

    _checkIsFirstLoad(settingsBloc, context);

    return BlocBuilder(
      bloc: scheduleBloc,
      buildWhen: (ScheduleState previous, ScheduleState current) =>
          previous.currentDate.weekday != current.currentDate.weekday,
      builder: (BuildContext context, ScheduleState schState) {
        return BlocBuilder(
          bloc: settingsBloc,
          buildWhen: (SettingsState previous, SettingsState current) {
            if (previous.settings.langID != current.settings.langID)
              return true;
            return false;
          },
          builder: (BuildContext context, SettingsState state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                actions: state.settings.numOfWeeks != 1
                    ? [WeekSelector(state.settings.numOfWeeks)]
                    : [],
                title: Text(
                  DateService.getWeekDayFromNum(
                          schState.currentDate.weekday, state.settings.langID)
                      .toString(),
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                height: MediaQuery.of(context).size.shortestSide * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularIcon(
                      icon: Icons.add_box_outlined,
                      onTapFunc: () {
                        print("TEST");
                      },
                    ),
                    CircularIcon(
                      icon: Icons.notifications_outlined,
                      onTapFunc: () {
                        print("TEST");
                      },
                    ),
                    CircularIcon(
                      icon: Icons.settings_outlined,
                      onTapFunc: () {
                        print("TEST");
                      },
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  DaySelectorBanner(),
                  Expanded(
                    child: Center(
                      child: Text(
                        state.status.toString(),
                        // noClass[state.settings.langID].toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Function onTapFunc;
  const CircularIcon({required this.icon, required this.onTapFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapFunc();
      },
      borderRadius: BorderRadius.circular(20),
      splashColor: Colors.blue,
      child: Container(
        height: MediaQuery.of(context).size.shortestSide * 0.10,
        width: MediaQuery.of(context).size.shortestSide * 0.10,
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }
}
