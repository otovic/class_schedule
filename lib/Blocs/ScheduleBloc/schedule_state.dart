part of 'schedule_bloc.dart';

class ScheduleState {
  DateTime currentDate = DateTime.now();

  ScheduleState();

  ScheduleState.changeDate({required this.currentDate});
}
