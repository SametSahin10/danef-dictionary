import 'dart:convert';

import 'package:danef_dictionary/api/word_api.dart';
import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:danef_dictionary/widgets/word_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  Future<List<Word>> wordData;
  WordDatabase wordDatabase;
  Future<List<Word>> favoriteWords;

  String _animationFilePath = 'assets/animations/loading_word_list.json';

  @override
  void initState() {
    super.initState();
    wordData = getWordData();
  }

  @override
  Widget build(BuildContext context) {
    wordDatabase = WordDatabase();
    favoriteWords = wordDatabase.getWords();
    return FutureBuilder<List<List<Word>>>(
      future: Future.wait([wordData, favoriteWords]),
      builder: (context, wordSnapshot) {
        if (wordSnapshot.connectionState == ConnectionState.done) {
          var words = wordSnapshot.data[0];
          var favoriteWords = wordSnapshot.data[1];
          if (wordSnapshot.hasError) {
            return Center(child: Icon(Icons.error));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: words.length,
            itemBuilder: (context, index) {
              return _isInFavorites(favoriteWords, words[index]) ?
                         WordTile(words[index], isFavourite: true) :
                         WordTile(words[index], isFavourite: false);
            }
          );
        } else {
          return Center(
            child: LottieView.fromFile(
              autoPlay: true,
              loop: true,
              onViewCreated: null,
              filePath: _animationFilePath
            )
          );
        }
      },
    );
  }

  Future<List<Word>> getWordData() async {
    var words = await WordAPI().getWords();
    var wordMap = json.decode(words);
    var wordList = WordList();
    wordList = WordList.fromJson(wordMap);
    return wordList.words;
  }

   _isInFavorites(List<Word> words, Word word) {
    if (words == null) {
      return false;
    }
    for (final element in words) {
      if (element.adige == word.adige) {
        return true;
      }
    }
    return false;
  }
}

