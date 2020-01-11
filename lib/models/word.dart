import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';
part 'word.g.dart';

final String tableWords = 'words';
final String columnId = '_id';
final String columnAdige = 'adige';
final String columnTurkish = 'turkish';

@JsonSerializable()
class Word {
  int id;
  String adige;
  String turkish;
  Word(this.adige, this.turkish);

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnAdige: adige,
      columnTurkish: turkish
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    adige = map[columnAdige];
    turkish = map[columnTurkish];
  }
}

@JsonSerializable()
class WordList {
  List<Word> words;

  WordList({this.words});

  factory WordList.fromJson(List<dynamic> json) {
    return WordList(
      words: json
          .map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList());
  }
}

class WordProvider {
  Database db;

  Future open(String path) async {
     db = await openDatabase(
          path, version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''
              CREATE TABLE $tableWords (
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
                $columnAdige TEXT NOT NULL,
                $columnTurkish TEXT NOT NULL)
            ''');
          }
        );
  }

  Future<Word> insert(Word word) async {
    word.id = await db.insert(tableWords, word.toMap());
    return word;
  }

  Future<Word> getWord(int id) async {
    List<Map> maps = await db.query(tableWords,
      columns: [columnId, columnAdige, columnTurkish],
      where: '$columnId = ?',
      whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableWords, where: '$id = ?', whereArgs: [id]);
  }

  Future<int> update(Word word) async {
    return await db.update(tableWords, word.toMap(),
        where: '$columnId = ?',
        whereArgs: [word.id]);
  }

  Future close() => db.close();
}