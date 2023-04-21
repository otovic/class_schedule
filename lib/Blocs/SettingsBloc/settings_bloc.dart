import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Services/database_service.dart';
import '../../Models/settings_model.dart';

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
    on<ChangeWeekNum>((event, emit) => _changeWeekNum(event, emit));
    on<ChangeSelectedWeek>((event, emit) => _setNewWeek(event, emit));
    add(const InitSettings());
  }

  Future<void> _initSettings(
      SettingsEvents event, Emitter<SettingsState> emit) async {
    try {
      String path = await DatabaseService.getStoragePath();
      List<dynamic> settingsDb =
          await DatabaseService.initDatabase(path, "settings");

      if (settingsDb[0] == false) {
        emit(SettingsState.setValues(
            Settings.defaultValues, loadStatus.firstLoad));
        return;
      }

      List<Map<dynamic, dynamic>> settingsRes =
          await _readSettings(settingsDb[1], "SELECT * FROM settings");

      if (settingsRes.length != 5) {
        emit(SettingsState.setValues(
            Settings.defaultValues, loadStatus.firstLoad));
        return;
      }
      emit(
        SettingsState.setValues(
            Settings(
              settingsRes[0]['settingValue'].toString(),
              int.parse(settingsRes[1]['settingValue']),
              settingsRes[3]['settingValue'],
              int.parse(settingsRes[4]['settingValue']),
            ),
            loadStatus.loaded),
      );
    } catch (error) {
      emit(SettingsState.setValues(
          const Settings("en", 1, 'light', 1), loadStatus.error));
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
        "INSERT INTO settings (id, settingID, settingValue) VALUES (2, 2, '1')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    query =
        "INSERT INTO settings (id, settingID, settingValue) VALUES (3, 3, '24')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    query =
        "INSERT INTO settings (id, settingID, settingValue) VALUES (4, 4, 'light')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    query =
        "INSERT INTO settings (id, settingID, settingValue) VALUES (5, 5, '1')";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    emit(SettingsState.setValues(
        Settings(event.lang, 1, 'light', 1), loadStatus.loaded));
  }

  Future<void> _changeTheme(
      ChangeTheme event, Emitter<SettingsState> emit) async {
    String path = await DatabaseService.getStoragePath();

    List<dynamic> dbStatus =
        await DatabaseService.initDatabase(path, "settings");

    String query =
        "UPDATE settings SET settingValue = '${state.settings.theme == 'light' ? 'dark' : 'light'}' WHERE id = 4";

    await DatabaseService.runInsertQuery(dbStatus[1], query);

    emit(
      SettingsState.setValues(
          Settings(
              state.settings.langID,
              state.settings.numOfWeeks,
              state.settings.theme == 'light' ? 'dark' : 'light',
              state.settings.selectedWeek),
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
        Settings(event.language, state.settings.numOfWeeks,
            state.settings.theme, state.settings.selectedWeek),
        state.status));
  }

  Future<void> _changeWeekNum(
      ChangeWeekNum event, Emitter<SettingsState> emit) async {
    String path = await DatabaseService.getStoragePath();

    List<dynamic> dbStatus =
        await DatabaseService.initDatabase(path, "settings");

    if (state.settings.numOfWeeks + 1 > 4) {
      String query = "UPDATE settings SET settingValue = '${1}' WHERE id = 2";

      await DatabaseService.runInsertQuery(dbStatus[1], query);

      query = "UPDATE settings SET settingValue = '${1}' WHERE id = 5";

      await DatabaseService.runInsertQuery(dbStatus[1], query);

      emit(
        SettingsState.setValues(
          Settings(state.settings.langID, 1, state.settings.theme, 1),
          state.status,
        ),
      );
    } else {
      String query =
          "UPDATE settings SET settingValue = '${state.settings.numOfWeeks + 1}' WHERE id = 2";

      await DatabaseService.runInsertQuery(dbStatus[1], query);

      emit(
        SettingsState.setValues(
          Settings(state.settings.langID, state.settings.numOfWeeks + 1,
              state.settings.theme, state.settings.selectedWeek),
          state.status,
        ),
      );
    }
  }

  Future<List<Map<dynamic, dynamic>>> _readSettings(
      Database db, String query) async {
    return await DatabaseService.executeQuery(db, query);
  }

  Future<void> _setNewWeek(
      ChangeSelectedWeek event, Emitter<SettingsState> emit) async {
    try {
      String path = await DatabaseService.getStoragePath();

      List<dynamic> dbStatus =
          await DatabaseService.initDatabase(path, "settings");

      await DatabaseService.runInsertQuery(dbStatus[1],
          "UPDATE settings SET settingValue = '${event.newWeek}' WHERE id = 5");

      emit(SettingsState.setValues(
          Settings(state.settings.langID, state.settings.numOfWeeks,
              state.settings.theme, event.newWeek),
          state.status));
    } catch (error) {}
  }
}
