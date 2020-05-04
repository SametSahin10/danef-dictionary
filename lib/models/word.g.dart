// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word(
      json['ID'] as int, json['adige'] as String, json['turkish'] as String)
    ..numOfTimesSearched = json['numOfTimesSearched'] as int;
}

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'ID': instance.wordId,
      'adige': instance.adige,
      'turkish': instance.turkish,
      'numOfTimesSearched': instance.numOfTimesSearched
    };

WordList _$WordListFromJson(Map<String, dynamic> json) {
  return WordList(
      words: (json['words'] as List)
          ?.map((e) =>
              e == null ? null : Word.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$WordListToJson(WordList instance) =>
    <String, dynamic>{'words': instance.words};
