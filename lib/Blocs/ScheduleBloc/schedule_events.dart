part of 'schedule_bloc.dart';

abstract class ScheduleEvent {
  const ScheduleEvent();
}

class ChangeDate extends ScheduleEvent {
  final DateTime newDate;
  const ChangeDate(this.newDate);
}

class ChangeWeek extends ScheduleEvent {
  final int newWeek;
  const ChangeWeek(this.newWeek);
}

class InitWeek extends ScheduleEvent {
  const InitWeek();
}

class InitSchedule extends ScheduleEvent {
  const InitSchedule();
}

class AddNewSubject extends ScheduleEvent {
  final Subject subject;
  const AddNewSubject(this.subject);
}
