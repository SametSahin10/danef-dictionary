import 'dart:convert';

import 'package:danef_dictionary/api/word_api.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  Future wordData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wordData = getWordData();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
      builder: (context, wordSnapshot) {
        if (wordSnapshot.connectionState == ConnectionState.done) {
          if (wordSnapshot.hasError) {
            return Center(child: Icon(Icons.error));
          }
          return ListView.builder(
            itemCount: wordSnapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(wordSnapshot.data[index].adige)
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: wordData,
    );
  }

  Future<List<Word>> getWordData() async {
    var words = await WordAPI().getWords();
    var wordMap = json.decode(words);
    var wordList = WordList();
    wordList = WordList.fromJson(wordMap);
    return wordList.words;
  }
}

