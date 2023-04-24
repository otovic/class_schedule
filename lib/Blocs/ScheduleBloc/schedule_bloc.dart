import 'package:classschedule_app/Services/date_service.dart';
import 'package:classschedule_app/Services/utility.dart';
import 'package:classschedule_app/models/subject_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/database_service.dart';
import '../../models/homework.dart';

part 'schedule_events.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc()
      : super(ScheduleState.init(
            currentDate: DateTime.now(), selectedWeek: 1, subjects: [])) {
    on<ChangeDate>((event, emit) => _setNewDate(event, emit));
    on<InitSchedule>((event, emit) => _initSettings(event, emit));
    on<AddNewSubject>((event, emit) => _addSubject(event, emit));
    on<AddNewHomework>((event, emit) => _addNewHomework(event, emit));
    add(const InitSchedule());
  }

  Future<void> _setNewDate(
      ChangeDate event, Emitter<ScheduleState> emit) async {
    emit(ScheduleState.init(
        currentDate: event.newDate,
        subjects: state.subjects,
        selectedWeek: state.selectedWeek));
  }

  Future<void> _addNewHomework(
      AddNewHomework event, Emitter<ScheduleState> emit) async {
    Homework homework = event.homework;
    String path = await DatabaseService.getStoragePath();

    List<dynamic> homeworkDb =
        await DatabaseService.initDatabase(path, "homeworks");

    await DatabaseService.runInsertQuery(
      homeworkDb[1],
      "INSERT INTO homeworks (subjectID, name, description, dueDate, completed) VALUES ('${homework.id}', '${homework.name}', '${homework.description}', '${DateService.encodeDate(homework.dueDate)})', '${UtilityService.encodeBool(homework.completed)}')",
    );

    List<Subject> newList = [];

    state.subjects.forEach((element) {
      if (element.subjectID == event.homework.id) {
        element.homeworks.add(event.homework);
      }

      newList.add(element);
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

    List<Subject> newList = [];

    for (var element in state.subjects) {
      newList.add(element);
    }

    newList.add(subject);

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
    try {
      String path = await DatabaseService.getStoragePath();
      List<dynamic> scheduleDb =
          await DatabaseService.initDatabase(path, "class_schedule");

      List<dynamic> homeworkDb =
          await DatabaseService.initDatabase(path, "homeworks");

      List<Map<dynamic, dynamic>> list = await DatabaseService.executeQuery(
          scheduleDb[1], "SELECT * FROM class_schedule");

      List<Map<dynamic, dynamic>> homeworkFetch =
          await DatabaseService.executeQuery(
              homeworkDb[1], "SELECT * FROM homeworks");

      List<Subject> newList = [];

      print(homeworkFetch.length);

      // DatabaseService.Truncate(homeworkDb[1]);

      list.forEach((element) async {
        List<Homework> homeworksList = [];

        homeworkFetch.forEach((homeworkItem) {
          if (homeworkItem['subjectID'] == element['subjectID']) {
            homeworksList.add(Homework(
              id: homeworkItem['subjectID'],
              name: homeworkItem['name'],
              description: homeworkItem['description'],
              dueDate: DateService.decodeDate(homeworkItem['duedate']),
              completed: UtilityService.decodeBool(homeworkItem['completed']),
            ));
          }
        });

        newList.add(
          Subject(
            subjectID: element['subjectID'],
            nameOfSubject: element['subjectName'],
            professorName: element['professor'],
            classroom: element['classroom'],
            color: UtilityService.decodeColor(element['color']),
            day: element['day'],
            week: element['week'],
            startTime: UtilityService.decodeTime(element['startTime']),
            endTime: UtilityService.decodeTime(element['endTime']),
            homeworks: homeworksList,
          ),
        );
      });

      print(newList);

      emit(
        ScheduleState.init(
          currentDate: state.currentDate,
          selectedWeek: state.selectedWeek,
          subjects: newList,
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
