part of 'schedule_bloc.dart';

abstract class ScheduleEvent {
  const ScheduleEvent();
}

class ChangeDate extends ScheduleEvent {
  final DateTime newDate;
  const ChangeDate(this.newDate);
}
