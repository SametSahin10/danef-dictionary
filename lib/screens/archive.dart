import 'package:danef_dictionary/api/api.dart';
import 'package:danef_dictionary/config/assets.dart';
import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:danef_dictionary/widgets/word_tile.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    wordDatabase = WordDatabase();
    favoriteWords = wordDatabase.getWords();
    return FutureBuilder<List<List<Word>>>(
      future: Future.wait([wordData, favoriteWords]),
      builder: (context, wordSnapshot) {
        if (wordSnapshot.connectionState == ConnectionState.done) {
          final words = wordSnapshot.data[0];
          final favoriteWords = wordSnapshot.data[1];
          if (wordSnapshot.hasError || words == null) {
            return Center(child: Icon(Icons.error));
          }
          if (words.isEmpty) {
            return Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.65,
                    height: screenHeight * 0.65,
                    child: Lottie.asset(Assets.couldNotFindWords),
                  ),
                  Text(
                    tr("archive.could_not_find_words"),
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            );
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
                return _isInFavorites(favoriteWords, words[index])
                    ? WordTile(words[index], isFavourite: true)
                    : WordTile(words[index], isFavourite: false);
              });
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
