import 'dart:developer';

import 'package:reminder_app_rs2/models/reminder_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  String dbname = "reminderdb.db";
  String tableName = "reminderTable3";

  Database? database;

  Future<void> initialize() async {
    String databasesPath = await getDatabasesPath();
    String fullPath = databasesPath + "dbname";

    await openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) async {
        String command1 =
            "CREATE TABLE $tableName(id TEXT PRIMARY KEY, taskName TEXT, scheduleDate TEXT)";
        await db.execute(command1);
        database = db;
        log("Database Created!");
      },
      onOpen: (db) {
        database = db;
        log("Database Opened!");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        database = db;
      },
      onDowngrade: (db, oldVersion, newVersion) {
        database = db;
      },
    );
  }

  Future<int> saveReminder(Reminder reminder) async {
    int saveResult = await database!.insert(tableName, reminder.toJson());
    return saveResult;
  }

  Future<int> deleteReminder(Reminder reminder) async {
    int deleteResult = await database!
        .delete(tableName, where: "id=?", whereArgs: [reminder.id]);
    return deleteResult;
  }

  Future<List<Reminder>> fetchReminder() async {
    List<Map<String, Object?>> reminderMaps = await database!.query(tableName);

    List<Reminder> reminders = [];
    for (var reminderMap in reminderMaps) {
      reminders.add(Reminder.fromJson(reminderMap));
    }

    return reminders;
  }
}
