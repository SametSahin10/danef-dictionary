import 'dart:convert';

import 'package:danef_dictionary/api/word_api.dart';
import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  Future<List<Word>> wordData;
  WordDatabase wordDatabase;
  Future<List<Word>> favoriteWords;

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
        var words = wordSnapshot.data[0];
        var favoriteWords = wordSnapshot.data[1];
        if (wordSnapshot.connectionState == ConnectionState.done) {
          if (wordSnapshot.hasError) {
            return Center(child: Icon(Icons.error));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: words.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(
                    words[index].adige,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto'
                    ),
                  ),
                trailing: IconButton(
                  icon: _isInFavorites(favoriteWords, words[index]) ?
                          Icon(Icons.favorite, color: Colors.green) :
                          Icon(Icons.favorite_border, color: Colors.green),
                  onPressed: () => _isInFavorites(favoriteWords, words[index]) ?
                          _deleteFromFavorites(words[index]) :
                          _addWordToFavorites(words[index])
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
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

  _addWordToFavorites(Word word) {
    print('Adding ${word.adige} to favorites');
    wordDatabase.addWord(word);
    setState(() {});
  }

  _deleteFromFavorites(Word word) {
    print('Deleting ${word.adige} from favorites');
    wordDatabase.deleteWord(word.wordId);
    setState(() {});
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

