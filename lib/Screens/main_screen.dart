import 'package:classschedule_app/SettingsBloc/settings_bloc.dart';
import 'package:classschedule_app/Widgets/day_selector_banner.dart';
import 'package:classschedule_app/Widgets/week_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Services/date_service.dart';

class MainScreen extends StatelessWidget {
  SettingsBloc? settingBloc;
  MainScreen(this.settingBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: settingBloc,
      builder: (BuildContext context, SettingsState state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: state.settings.numOfWeeks != 1
                ? [WeekSelector(state.settings.numOfWeeks)]
                : [],
            title: Text(
              DateService.getWeekDayFromLang(state.settings.langID).toString(),
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: DaySelectorBanner(this.settingBloc),
        );
      },
    );
  }
}
