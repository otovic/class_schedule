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
      : super(
          ScheduleState.init(
            currentDate: DateTime.now(),
            selectedWeek: 1,
            numberOfWeeks: 1,
            subjects: [],
          ),
        ) {
    on<ChangeDate>((event, emit) => _setNewDate(event, emit));
    on<InitSchedule>((event, emit) => _initSettings(event, emit));
    on<AddNewSubject>((event, emit) => _addSubject(event, emit));
    on<AddNewHomework>((event, emit) => _addNewHomework(event, emit));
    on<ChangeWeekNumber>((event, emit) => _changeNumberOfWeeks(event, emit));
    on<ChangeSelectedWeek>((event, emit) => _changeSelectedWeek(event, emit));
    add(InitSchedule());
  }

  Future<void> _setNewDate(
      ChangeDate event, Emitter<ScheduleState> emit) async {
    emit(ScheduleState.init(
        currentDate: event.newDate,
        subjects: state.subjects,
        numberOfWeeks: state.numberOfWeeks,
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

    for (var element in state.subjects) {
      List<Homework> copy = [];

      for (var homework in element.homeworks) {
        copy.add(homework);
      }

      newList.add(
        Subject(
          subjectID: element.subjectID,
          nameOfSubject: element.nameOfSubject,
          professorName: element.professorName,
          classroom: element.classroom,
          color: element.color,
          day: element.day,
          week: element.week,
          startTime: element.startTime,
          endTime: element.endTime,
          homeworks: copy,
        ),
      );

      if (newList.last.subjectID == event.homework.id) {
        newList.last.homeworks.add(event.homework);
      }
    }

    emit(
      ScheduleState.init(
        currentDate: state.currentDate,
        selectedWeek: state.selectedWeek,
        numberOfWeeks: state.numberOfWeeks,
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
      "INSERT INTO class_schedule (subjectID, subjectName, professor, classroom, color, week, day, startTime, endTime) VALUES ('${subject.subjectID}', '${subject.nameOfSubject}', '${subject.professorName}', '${subject.classroom}', '${UtilityService.encodeColor(subject.color)}', ${subject.week}, ${subject.day}, '${UtilityService.encodeTime(subject.startTime)}', '${UtilityService.encodeTime(subject.endTime)}')",
    );

    List<dynamic> homeworkStatus =
        await DatabaseService.initDatabase(path, "homeworks");

    List<Map<dynamic, dynamic>> result = await DatabaseService.executeQuery(
        homeworkStatus[1],
        "SELECT * FROM homeworks WHERE subjectID = '${subject.subjectID}'");

    List<Subject> newList = [];

    for (var element in state.subjects) {
      newList.add(element);
    }

    for (var homework in result) {
      subject.homeworks.add(
        Homework(
          id: homework['subjectID'],
          name: homework['name'],
          description: homework['description'],
          dueDate: DateService.decodeDate(homework['duedate']),
          completed: UtilityService.decodeBool(homework['completed']),
        ),
      );
    }

    newList.add(subject);

    print(newList);

    emit(
      ScheduleState.init(
        currentDate: state.currentDate,
        selectedWeek: state.selectedWeek,
        numberOfWeeks: state.numberOfWeeks,
        subjects: newList,
      ),
    );
  }

  Future<void> _changeNumberOfWeeks(
      ChangeWeekNumber event, Emitter<ScheduleState> emit) async {
    String path = await DatabaseService.getStoragePath();

    List<dynamic> weekDb = await DatabaseService.initDatabase(path, "week");

    List<Map<dynamic, dynamic>> weekFetch = await DatabaseService.executeQuery(
        weekDb[1], "UPDATE week SET week = ${event.newWeek} WHERE id = 1");

    emit(
      ScheduleState.init(
        currentDate: state.currentDate,
        selectedWeek: event.newWeek == 1 ? 1 : state.selectedWeek,
        numberOfWeeks: event.newWeek,
        subjects: state.subjects,
      ),
    );
  }

  Future<void> _changeSelectedWeek(
      ChangeSelectedWeek event, Emitter<ScheduleState> emit) async {
    String path = await DatabaseService.getStoragePath();

    List<dynamic> weekDb = await DatabaseService.initDatabase(path, "week");

    List<Map<dynamic, dynamic>> weekFetch = await DatabaseService.executeQuery(
        weekDb[1], "UPDATE week SET week = ${event.newWeek} WHERE id = 0");

    emit(
      ScheduleState.init(
        currentDate: state.currentDate,
        selectedWeek: event.newWeek,
        numberOfWeeks: state.numberOfWeeks,
        subjects: state.subjects,
      ),
    );
  }

  Future<void> _initSettings(
      InitSchedule event, Emitter<ScheduleState> emit) async {
    try {
      String path = await DatabaseService.getStoragePath();
      List<dynamic> scheduleDb =
          await DatabaseService.initDatabase(path, "class_schedule");

      List<dynamic> homeworkDb =
          await DatabaseService.initDatabase(path, "homeworks");

      List<dynamic> weekDb = await DatabaseService.initDatabase(path, "week");

      List<Map<dynamic, dynamic>> list = await DatabaseService.executeQuery(
          scheduleDb[1], "SELECT * FROM class_schedule");

      List<Map<dynamic, dynamic>> homeworkFetch =
          await DatabaseService.executeQuery(
              homeworkDb[1], "SELECT * FROM homeworks");

      List<Map<dynamic, dynamic>> weekFetch =
          await DatabaseService.executeQuery(weekDb[1], "SELECT * FROM week");

      if (weekFetch.isEmpty) {
        await DatabaseService.executeQuery(
            weekDb[1], "INSERT INTO week (week) VALUES (1)");
        await DatabaseService.executeQuery(
            weekDb[1], "INSERT INTO week (week) VALUES (1)");
        weekFetch.add({"week": 1});
        weekFetch.add({"week": 1});
      }

      List<Subject> newList = [];

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

      emit(
        ScheduleState.init(
          currentDate: state.currentDate,
          selectedWeek: weekFetch[0]['week'],
          numberOfWeeks: weekFetch[1]['week'],
          subjects: newList,
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
