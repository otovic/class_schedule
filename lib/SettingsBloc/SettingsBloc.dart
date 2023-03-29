import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/SettingsModel.dart';
import '../Services/DatabaseService.dart';
import '../constants/constants.dart';

part './SettingsState.dart';
part './SettingsEvents.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingsState> {
  SettingsBloc() : super(SettingsState.setValues(Settings.defaultValues, loadStatus.loading)) {
    _initSettings();
  }

  Future<void> _initSettings() async {
    try {
      String path = await DatabaseService.getStoragePath();
      List<dynamic> dbStatus = await DatabaseService.initDatabase(path, "settings");

      if(dbStatus[0] == false) {
        print("Baza ne postoji");
        emit(SettingsState.setValues(Settings.defaultValues, loadStatus.firstLoad));
        return;
      }

      List<Map<dynamic, dynamic>> result = await _readSettings(dbStatus[1] as Database, readSettingsQuery);
      print(result);

      if(result[0]['settingID'] == 1) {
        emit(SettingsState.setValues(new Settings(result[0]['settingValue'], result[1]['settingValue']), loadStatus.loaded));
        return;
      }

      emit(SettingsState.setValues(new Settings(result[1]['settingValue'], result[0]['settingValue']), loadStatus.loaded));
    } catch(error) {
      print("Doslo je do greske!");
      emit(SettingsState.setValues(new Settings(1, 45), loadStatus.error));
    }
  }

  Future<List<Map<dynamic, dynamic>>> _readSettings (Database db, String query) async {
    return await DatabaseService.executeQuery(db, query);
  }
}