import 'package:json_annotation/json_annotation.dart';
part 'word.g.dart';

@JsonSerializable()
class Word {
  String adige;
  String turkish;
  Word(this.adige, this.turkish);

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);
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