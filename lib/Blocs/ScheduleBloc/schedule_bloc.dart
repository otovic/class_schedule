import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/database_service.dart';

part 'schedule_events.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc()
      : super(
            ScheduleState.init(currentDate: DateTime.now(), selectedWeek: 1)) {
    on<ChangeDate>((event, emit) => _setNewDate(event, emit));
  }

  Future<void> _setNewDate(
      ChangeDate event, Emitter<ScheduleState> state) async {
    emit(ScheduleState.changeDate(currentDate: event.newDate));
  }

  Future<void> _initWeek(
      ScheduleEvent event, Emitter<ScheduleState> emit) async {
    String path = await DatabaseService.getStoragePath();

    List<dynamic> dbStatus =
        await DatabaseService.initDatabase(path, "schedule_settings");

    if (dbStatus[0] == false) {
      String query =
          "INSERT INTO schedule_settings (id, settingID, settingValue) VALUES (1, 1, '${1}')";

      await DatabaseService.runInsertQuery(dbStatus[1], query);
      return;
    }

    String query = "SELECT * FROM schedule_settings";

    List<Map<dynamic, dynamic>> results =
        await DatabaseService.executeQuery(dbStatus[1], query);

    emit(
      ScheduleState.init(
        currentDate: state.currentDate,
        selectedWeek: int.parse(results[0]['settingValue']),
      ),
    );
  }

  Future<void> _setNewWeek(
      ChangeWeek event, Emitter<ScheduleState> emit) async {
    try {
      String path = await DatabaseService.getStoragePath();

      List<dynamic> dbStatus =
          await DatabaseService.initDatabase(path, "schedule_settings");

      await DatabaseService.runInsertQuery(dbStatus[1],
          "UPDATE schedule_settings SET settingValue = '${event.newWeek}' WHERE id = 1");

      emit(
        ScheduleState.init(
            currentDate: state.currentDate, selectedWeek: event.newWeek),
      );
    } catch (error) {}
  }
}
