import 'package:littlewords/beans/dto/word.dto.dart';
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

  static const String tableName = "words";

  static const String createTable = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      uid INTEGER PRIMARY KEY NOT NULL,
      username VARCHAR NOT NULL
    )
  ''';

  static const String dropTable = '''
    DROP TABLE IF EXISTS $tableName
  ''';


  static  _onCreate(Database db, int version) {
    db.execute(createTable);
  }

  static _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute(dropTable);

    _onCreate(db, newVersion);
  }

  /// Inserer une ligne dans la table
  void insert(WordDTO word){
    final Map<String, dynamic> wordAsMap = word.toJson();
    _db!.insert(tableName, wordAsMap);
  }

  /// Récupérer toutes les lignes de la table
  Future<List<WordDTO>> findAll() async {
    final List<Map<String, Object?>> resultSet = await _db!.query(tableName);
    if(resultSet.isEmpty){
      return [];
    }

    // convertir chaque ligne du ResultSet en WordDTO
    final List<WordDTO> words = [];
    for (var rs in resultSet) {
      var wordDTO = WordDTO.fromJson(rs);
      words.add(wordDTO);
    }

    return words;
  }
}