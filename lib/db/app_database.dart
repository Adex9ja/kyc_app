import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_starter_app/db/task_dao.dart';
import 'package:flutter_starter_app/model/bank_entity.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 6, entities: [BankEntity])
abstract class AppDatabase extends FloorDatabase{
  static AppDatabase _instance;

  static AppDatabase getInstance() {
    return _instance;
  }

  TaskDao get taskDao;


  static Future<void>  init() async {
    _instance = await $FloorAppDatabase.databaseBuilder("kyc_app.db").build();
  }
}