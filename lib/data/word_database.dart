import 'dart:io';

import 'package:danef_dictionary/models/word.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableWords = 'words';
final String columnId = '_id';
final String columnWordId = 'word_id';
final String columnAdige = 'adige';
final String columnTurkish = 'turkish';

class WordDatabase {
  static final WordDatabase _instance = WordDatabase._();
  static Database _database;

  WordDatabase._();

  factory WordDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "words.db");
    var database = await openDatabase(
        path, version: 1,
        onCreate: _onCreate,
    );
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableWords (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnWordId INTEGER NOT NULL,
          $columnAdige TEXT NOT NULL,
          $columnTurkish TEXT NOT NULL)
      ''');
  }

  Future<Word> addWord(Word word) async {
    var client = await db;
    word.id = await client.insert(tableWords, word.toMap());
    return word;
  }

  Future<Word> getWord(int id) async {
    var client = await db;
    List<Map> maps = await client.query(tableWords,
        columns: [columnId, columnWordId, columnAdige, columnTurkish],
        where: '$columnWordId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Word>> getWords() async {
    var client = await db;
    List<Map<String, dynamic>> result = await client.query(tableWords,
        columns: [columnId, columnWordId, columnAdige, columnTurkish]);
    if (result.length > 0) {
      List<Word> words = result.map((e) => (Word.fromMap(e))).toList();
      return words;
    }
    return null;
  }

  Future<int> deleteWord(int id) async {
    var client = await db;
    return await client.delete(tableWords,
        where: '$columnWordId = ?', whereArgs: [id]);
  }

  Future<int> updateWord(Word word) async {
    var client = await db;
    return await client.update(tableWords, word.toMap(),
        where: '$columnWordId = ?',
        whereArgs: [word.id]);
  }

  Future close() async {
    var client = await db;
    client.close();
  }
}