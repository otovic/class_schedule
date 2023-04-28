part of 'schedule_bloc.dart';

class ScheduleState {
  DateTime currentDate = DateTime.now();
  int selectedWeek = 1;
  int numberOfWeeks = 1;
  List<Subject> subjects = [];

  ScheduleState();

  ScheduleState.changeDate({required this.currentDate});

  ScheduleState.initSelectedWeek({required this.selectedWeek});

  ScheduleState.init(
      {required this.currentDate,
      required this.selectedWeek,
      required this.numberOfWeeks,
      required this.subjects});
}
