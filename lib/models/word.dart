import 'package:json_annotation/json_annotation.dart';
part 'word.g.dart';

final String tableWords = 'words';
final String columnId = '_id';
final String columnWordId = 'word_id';
final String columnAdige = 'adige';
final String columnTurkish = 'turkish';

@JsonSerializable()
class Word {
  @JsonKey(ignore: true)
  int id;
  @JsonKey(name: 'ID')
  int wordId;
  String adige;
  String turkish;
  int numOfTimesSearched;
  Word(this.wordId, this.adige, this.turkish);

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnWordId: wordId,
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
    wordId = map[columnWordId];
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