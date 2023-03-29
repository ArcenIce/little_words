import 'package:sqflite/sqflite.dart';

class DbHelper{
  static const String _dbName = 'littlewords.db';
  static const int _dbVersion = 1;

  static Database? _db;

  static initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = dbPath + _dbName;
    final Database database = await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    _db = database;
  }

  static  _onCreate(Database db, int version) {
  }

  static _onUpgrade(Database db, int oldVersion, int newVersion) {
  }
}