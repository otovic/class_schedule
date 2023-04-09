import 'package:classschedule_app/Blocs/ScheduleBloc/schedule_bloc.dart';
import 'package:classschedule_app/Blocs/SettingsBloc/settings_bloc.dart';
import 'package:classschedule_app/Services/date_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekDayBox extends StatelessWidget {
  final DateTime date;
  WeekDayBox(this.date, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder(
        bloc: settingsBloc,
        buildWhen: (SettingsState previous, SettingsState current) {
          if (previous.settings.langID != current.settings.langID) return true;
          return false;
        },
        builder: (BuildContext context, SettingsState settingsState) {
          return BlocBuilder(
              bloc: scheduleBloc,
              buildWhen: (ScheduleState previous, ScheduleState current) {
                if (DateService.equalDates(previous.currentDate, this.date) &&
                    DateService.equalDates(current.currentDate, this.date)) {
                  return false;
                }
                if (DateService.equalDates(previous.currentDate, this.date) ||
                    DateService.equalDates(current.currentDate, this.date)) {
                  return true;
                }
                return false;
              },
              builder: (BuildContext context, ScheduleState state) {
                return GestureDetector(
                  onTap: () =>
                      context.read<ScheduleBloc>().add(ChangeDate(this.date)),
                  child: Container(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.shortestSide * 0.2,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.shortestSide * 0.15,
                        height: MediaQuery.of(context).size.shortestSide * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: DateService.equalDates(
                                    state.currentDate, this.date)
                                ? Colors.black
                                : Colors.grey,
                            width: DateService.equalDates(
                                    state.currentDate, this.date)
                                ? 2
                                : 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateService.getWeekDayFromNum(date.weekday,
                                      settingsState.settings.langID)
                                  .toString()
                                  .substring(0, 3),
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateService.getMonthFromNum(
                                      date.month, settingsState.settings.langID)
                                  .toString()
                                  .substring(0, 3),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
