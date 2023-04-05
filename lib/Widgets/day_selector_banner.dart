import 'package:classschedule_app/SettingsBloc/settings_bloc.dart';
import 'package:classschedule_app/Widgets/week_day_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaySelectorBanner extends StatelessWidget {
  SettingsBloc? settingsBloc;
  DaySelectorBanner(this.settingsBloc, {Key? key}) : super(key: key);

  List<WeekDayBox> _generateBoxes(String lang) {
    bool first = true;
    List<WeekDayBox>? boxes = [];
    DateTime date = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (first) {
        boxes.add(WeekDayBox(date, lang));
        first = false;
      } else {
        date = date.add(Duration(days: 1));
        boxes.add(WeekDayBox(date, lang));
      }
    }

    return boxes;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: this.settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 236, 236, 236),
              ),
            ),
            color: Colors.white,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _generateBoxes(state.settings.langID),
              )
            ],
          ),
        );
      },
    );
  }
}
