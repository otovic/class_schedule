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
    on<insertDefaultLanguage>(
        (event, emit) => _insertDefaultLanguage(event, emit));
    on<ChangeTheme>((event, emit) => _changeTheme(event, emit));
    on<ChangeLanguage>((event, emit) => _changeLanguage(event, emit));
    add(const InitSettings());
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

      if (result.length != 5) {
        emit(SettingsState.setValues(
            Settings.defaultValues, loadStatus.firstLoad));
        return;
      }

      emit(SettingsState.setValues(
          Settings(
              result[0]['settingValue'].toString(),
              int.parse(result[1]['settingValue']),
              int.parse(result[2]['settingValue']),
              result[4]['settingValue']),
          loadStatus.loaded));
    } catch (error) {
      emit(SettingsState.setValues(
          new Settings("en", 45, 1, 'light'), loadStatus.error));
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

    query =
        "INSERT INTO settings (id, settingID, settingValue) VALUES (5, 4, 'light')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    emit(SettingsState.setValues(
        new Settings(event.lang, 45, 1, 'light'), loadStatus.loaded));
  }

  Future<void> _changeTheme(
      ChangeTheme event, Emitter<SettingsState> emit) async {
    String path = await DatabaseService.getStoragePath();

    List<dynamic> dbStatus =
        await DatabaseService.initDatabase(path, "settings");

    String query =
        "UPDATE settings SET settingValue = '${state.settings.theme == 'light' ? 'dark' : 'light'}' WHERE id = 5";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    emit(
      SettingsState.setValues(
          Settings(
              state.settings.langID,
              state.settings.classLenght,
              state.settings.numOfWeeks,
              state.settings.theme == 'light' ? 'dark' : 'light'),
          state.status),
    );
  }

  Future<void> _changeLanguage(
      ChangeLanguage event, Emitter<SettingsState> emit) async {
    String path = await DatabaseService.getStoragePath();

    List<dynamic> dbStatus =
        await DatabaseService.initDatabase(path, "settings");

    String query =
        "UPDATE settings SET settingValue = '${event.language}' WHERE id = 1";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    emit(SettingsState.setValues(
        Settings(event.language, state.settings.classLenght,
            state.settings.numOfWeeks, state.settings.theme),
        state.status));
  }

  Future<List<Map<dynamic, dynamic>>> _readSettings(
      Database db, String query) async {
    return await DatabaseService.executeQuery(db, query);
  }
}
