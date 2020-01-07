import 'dart:convert';

import 'package:danef_dictionary/api/word_api.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
      builder: (context, wordSnapshot) {
        switch (wordSnapshot.connectionState) {
          case ConnectionState.none:
            return Icon(Icons.error);
          case ConnectionState.waiting:
          case ConnectionState.active:
            return CircularProgressIndicator();
          case ConnectionState.done:
            if (wordSnapshot.hasError) {
              return Icon(Icons.error);
            } else {
              return ListView.builder(
                itemCount: wordSnapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(wordSnapshot.data[index].adige)
                  );
                },
              );
            }
            break;
          default: return Icon(Icons.error);
        }
      },
      future: getWordData(),
    );
  }

  Future<List<Word>> getWordData() async {
    var words = await WordAPI().getWords();
    var wordMap = json.decode(words);
    var wordList = WordList();
    setState(() {
      wordList = WordList.fromJson(wordMap);
    });
    return wordList.words;
  }
}

