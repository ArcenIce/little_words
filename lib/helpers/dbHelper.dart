import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String _dbName = 'littlewords.db';
  static const int _dbVersion = 1;

  static Database? _db;

  static initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = dbPath + _dbName;
    final Database database = await openDatabase(path, version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    _db = database;
  }

  static const String tableName = "words";

  static const String createTable = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      uid INTEGER PRIMARY KEY NOT NULL,
      username VARCHAR NOT NULL,
      note VARCHAR NOT NULL
    )
  ''';

  static const String dropTable = '''
    DROP TABLE IF EXISTS $tableName
  ''';

  static _onCreate(Database db, int version) {
    db.execute(createTable);
  }

  static _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute(dropTable);

    _onCreate(db, newVersion);
  }

  Map<String, dynamic> toMap(uid, username, note) {
    return {
      'uid': uid,
      'username': username,
      'note': note,
    };
  }

  /// Inserer une ligne dans la table
  void insert(uid, username, note) {
    _db!.insert(tableName, toMap(uid, username, note));
  }

  void delete(uid) {
    _db!.delete(tableName, where: "uid = $uid");
  }

  /// Récupérer toutes les lignes de la table
  Future<List> findAll() async {
    await initDb();

    final List<Map<String, Object?>> resultSet = await _db!.query(tableName);
    if (resultSet.isEmpty) {
      return [];
    }

    return resultSet;
  }
}
