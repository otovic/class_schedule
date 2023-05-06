import 'package:classschedule_app/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final Map<String, List<String>> weekMap = {
  "en": ["Week 1", "Week 2", "Week 3", "Week 4"],
  "sr": ["Недеља 1", "Недеља 2", "Недеља 3", "Недеља 4"],
  "gr": ["Woche 1", "Woche 2", "Woche 3", "Woche 4"],
  "fr": ["Semaine 1", "Semaine 2", "Semaine 3", "Semaine 4"],
  "es": ["Semana 1", "Semana 2", "Semana 3", "Semana 4"],
  "it": ["Settimana 1", "Settimana 2", "Settimana 3", "Settimana 4"],
  "ru": ["Неделя 1", "Неделя 2", "Неделя 3", "Неделя 4"],
};

class WeekSelector extends StatelessWidget {
  const WeekSelector(this.numberOfWeeks, this.langID, {super.key});

  final int numberOfWeeks;
  final String langID;

  List<DropdownMenuItem<String>> _generateList() {
    List<DropdownMenuItem<String>> genList = [];
    for (int i = 0; i < numberOfWeeks; i++) {
      genList.add(
        DropdownMenuItem<String>(
          value: weekMap[langID]![i],
          child: Text(weekMap[langID]![i]),
        ),
      );
    }
    return genList;
  }

  @override
  Widget build(BuildContext context) {
    final ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);

    return BlocBuilder(
      bloc: scheduleBloc,
      builder: (BuildContext context, ScheduleState state) {
        return Container(
          margin: const EdgeInsets.only(top: 5, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: BlocBuilder(
            bloc: scheduleBloc,
            buildWhen: (ScheduleState previous, ScheduleState current) {
              return previous.selectedWeek != current.selectedWeek
                  ? true
                  : false;
            },
            builder: (BuildContext context, ScheduleState schState) {
              return DropdownButton<String>(
                underline: Container(),
                value: weekMap[langID]?[schState.selectedWeek - 1],
                items: _generateList(),
                onChanged: (value) {
                  scheduleBloc.add(
                    ChangeSelectedWeek(
                      ((weekMap[langID]?.indexOf(value!))! + 1),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
