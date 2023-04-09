import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Services/database_service.dart';
import '../../../constants/constants.dart';
import '../../Models/SettingsModel.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingsState> {
  SettingsBloc()
      : super(SettingsState.setValues(
            Settings.defaultValues, loadStatus.loading)) {
    on<InitSettings>((event, emit) => _initSettings(event, emit));
    // on<SettingsChanged>((event, emit) => _changeSettings(event, emit));
    // on<revertSetting>((event, emit) => _revert(event, emit));
    on<insertDefaultLanguage>(
        (event, emit) => _insertDefaultLanguage(event, emit));
    this.add(InitSettings());
  }

  Future<void> _changeSettings(
      SettingsEvents event, Emitter<SettingsState> emit) async {
    emit(SettingsState.setValues(Settings.defaultValues, loadStatus.loading));
  }

  Future<void> _revert(
      SettingsEvents event, Emitter<SettingsState> emit) async {
    emit(SettingsState.setValues(Settings.defaultValues, loadStatus.firstLoad));
  }

  Future<void> _initSettings(
      SettingsEvents event, Emitter<SettingsState> emit) async {
    try {
      String path = await DatabaseService.getStoragePath();
      List<dynamic> dbStatus =
          await DatabaseService.initDatabase(path, "settings");

      if (dbStatus[0] == false) {
        emit(SettingsState.setValues(
            Settings.defaultValues, loadStatus.firstLoad));
        return;
      }

      List<Map<dynamic, dynamic>> result =
          await _readSettings(dbStatus[1], readSettingsQuery);
      print("${result} ovo je duzina");

      if (result.length != 4) {
        emit(SettingsState.setValues(
            Settings.defaultValues, loadStatus.firstLoad));
        return;
      }

      print(result[1]['settingValue']);

      emit(SettingsState.setValues(
          new Settings(
              result[0]['settingValue'].toString(),
              int.parse(result[1]['settingValue']),
              int.parse(result[2]['settingValue'])),
          loadStatus.loaded));
    } catch (error) {
      print(error);
      emit(
          SettingsState.setValues(new Settings("en", 45, 1), loadStatus.error));
    }
  }

  Future<void> _insertDefaultLanguage(
      insertDefaultLanguage event, Emitter<SettingsState> emit) async {
    String path = await DatabaseService.getStoragePath();

    List<dynamic> dbStatus =
        await DatabaseService.initDatabase(path, "settings");

    String query =
        "INSERT INTO settings (id, settingID, settingValue) VALUES (1, 1, '${event.lang}')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    query =
        "INSERT INTO settings (id, settingID, settingValue) VALUES (2, 2, '45')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    query =
        "INSERT INTO settings (id, settingID, settingValue) VALUES (3, 3, '1')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    query =
        "INSERT INTO settings (id, settingID, settingValue) VALUES (4, 4, '24')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    emit(SettingsState.setValues(
        new Settings(event.lang, 45, 1), loadStatus.loaded));
  }

  Future<List<Map<dynamic, dynamic>>> _readSettings(
      Database db, String query) async {
    return await DatabaseService.executeQuery(db, query);
  }
}
