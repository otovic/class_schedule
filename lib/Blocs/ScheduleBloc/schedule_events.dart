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

class AddNewHomework extends ScheduleEvent {
  final Homework homework;
  const AddNewHomework(this.homework);
}

class ChangeWeekNumber extends ScheduleEvent {
  final int newWeek;
  const ChangeWeekNumber(this.newWeek);
}

class ChangeSelectedWeek extends ScheduleEvent {
  final int newWeek;
  const ChangeSelectedWeek(this.newWeek);
}

class DeleteHomework extends ScheduleEvent {
  final int homeworkID;
  const DeleteHomework(this.homeworkID);
}

class ChangeHomework extends ScheduleEvent {
  final Homework homework;
  const ChangeHomework(this.homework);
}

class MarkHomeworkComplete extends ScheduleEvent {
  final int homeworkID;
  const MarkHomeworkComplete(this.homeworkID);
}
