import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';

class DatabaseService {
  static Future<String> getStoragePath() async {
    return await getDatabasesPath();
  }

  static Future<List<dynamic>> initDatabase(String path, String dbName) async {
    bool dbExists = true;

    Database database = await openDatabase(path + dbName, version: 3,
        onCreate: (Database db, int version) async {
      await db.execute(dbCreateQuery[dbName]!).then((_) => dbExists = false);
    });

    return [dbExists, database];
  }

  static Future<bool> runInsertQuery(Database db, String query) async {
    int id1 = await db.rawInsert(query);
    return true;
  }

  static Future<bool> Truncate(Database db) async {
    await db.rawQuery("DELETE FROM settings WHERE id > 0");
    return true;
  }

  static Future<List<Map<dynamic, dynamic>>> executeQuery(
      Database db, String query) async {
    return db.rawQuery(query);
  }
}