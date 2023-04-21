import 'package:classschedule_app/Services/utility.dart';
import 'package:classschedule_app/models/subject_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/database_service.dart';

part 'schedule_events.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc()
      : super(ScheduleState.init(
            currentDate: DateTime.now(), selectedWeek: 1, subjects: [])) {
    on<ChangeDate>((event, emit) => _setNewDate(event, emit));
    on<InitSchedule>((event, emit) => _initSettings(event, emit));
    on<AddNewSubject>((event, emit) => _addSubject(event, emit));
    add(const InitSchedule());
  }

  Future<void> _setNewDate(
      ChangeDate event, Emitter<ScheduleState> emit) async {
    emit(ScheduleState.init(
        currentDate: event.newDate,
        subjects: state.subjects,
        selectedWeek: state.selectedWeek));
  }

  Future<void> _addSubject(
      AddNewSubject event, Emitter<ScheduleState> emit) async {
    Subject subject = event.subject;
    String path = await DatabaseService.getStoragePath();
    List<dynamic> dbStatus =
        await DatabaseService.initDatabase(path, "class_schedule");

    await DatabaseService.runInsertQuery(
      dbStatus[1],
      "INSERT INTO class_schedule (subjectID, subjectName, professor, classroom, color, week, day, startTime, endTime) VALUES ('${subject.subjectID}', '${subject.nameOfSubject}', '${subject.professorName}', '${subject.classroom}', '${UtilityService.encodeColor(subject.color)}', ${subject.day}, ${subject.week}, '${UtilityService.encodeTime(subject.startTime)}', '${UtilityService.encodeTime(subject.endTime)}')",
    );

    List<Map<dynamic, dynamic>> list = await DatabaseService.executeQuery(
        dbStatus[1], "SELECT * FROM class_schedule");

    List<Subject> newList = [];

    list.forEach((element) {
      newList.add(Subject(
          subjectID: element['subjectID'],
          nameOfSubject: element['subjectName'],
          professorName: element['professor'],
          classroom: element['classroom'],
          color: UtilityService.decodeColor(element['color']),
          day: element['day'],
          week: element['week'],
          startTime: UtilityService.decodeTime(element['startTime']),
          endTime: UtilityService.decodeTime(element['endTime'])));
    });

    emit(
      ScheduleState.init(
        currentDate: state.currentDate,
        selectedWeek: state.selectedWeek,
        subjects: newList,
      ),
    );
  }

  Future<void> _initSettings(
      ScheduleEvent event, Emitter<ScheduleState> emit) async {
    String path = await DatabaseService.getStoragePath();
    List<dynamic> dbStatus =
        await DatabaseService.initDatabase(path, "class_schedule");

    List<Map<dynamic, dynamic>> list = await DatabaseService.executeQuery(
        dbStatus[1], "SELECT * FROM class_schedule");

    print(list);

    List<Subject> newList = [];

    list.forEach((element) {
      newList.add(Subject(
          subjectID: element['subjectID'],
          nameOfSubject: element['subjectName'],
          professorName: element['professor'],
          classroom: element['classroom'],
          color: UtilityService.decodeColor(element['color']),
          day: element['day'],
          week: element['week'],
          startTime: UtilityService.decodeTime(element['startTime']),
          endTime: UtilityService.decodeTime(element['endTime'])));
    });

    print(newList);

    emit(
      ScheduleState.init(
        currentDate: state.currentDate,
        selectedWeek: state.selectedWeek,
        subjects: newList,
      ),
    );
  }
}
