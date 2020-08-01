import 'package:danef_dictionary/api/api.dart';
import 'package:danef_dictionary/config/assets.dart';
import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:danef_dictionary/widgets/word_tile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    wordData = Api.retrieveWords();
    super.initState();
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
          if (wordSnapshot.hasError || words == null) {
            return Center(child: Icon(Icons.error));
          }
          return ListView.separated(
              separatorBuilder: (_, index) {
                return Divider(
                  indent: 8,
                  endIndent: 8,
                  color: Colors.black26,
                );
              },
              padding: EdgeInsets.all(8),
              itemCount: words.length,
              itemBuilder: (context, index) {
                return _isInFavorites(favoriteWords, words[index]) ?
                WordTile(
                    words[index],
                    isFavourite: true
                ) :
                WordTile(
                    words[index],
                    isFavourite: false
                );
              }
          );
        } else {
          return Center(
            child: Lottie.asset(Assets.loading_words_anim_path),
          );
        }
      },
    );
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

