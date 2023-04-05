import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/SettingsModel.dart';
import '../Services/database_service.dart';
import '../constants/constants.dart';

part './settings_state.dart';
part './settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingsState> {
  SettingsBloc()
      : super(SettingsState.setValues(
            Settings.defaultValues, loadStatus.loading)) {
    on<InitSettings>((event, emit) => _initSettings(event, emit));
    on<SettingsChanged>((event, emit) => _changeSettings(event, emit));
    on<revertSetting>((event, emit) => _revert(event, emit));
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

      if (result.length != 2) {
        emit(SettingsState.setValues(
            Settings.defaultValues, loadStatus.firstLoad));
        return;
      }

      emit(SettingsState.setValues(
          new Settings(result[0]['settingValue'], result[1]['settingValue'],
              result[2]['settingValue']),
          loadStatus.loaded));
    } catch (error) {
      emit(
          SettingsState.setValues(new Settings("en", 45, 1), loadStatus.error));
    }
  }

  Future<List<Map<dynamic, dynamic>>> _readSettings(
      Database db, String query) async {
    return await DatabaseService.executeQuery(db, query);
  }
}
