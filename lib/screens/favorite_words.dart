import 'package:danef_dictionary/config/assets.dart';
import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:easy_localization/public.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FavoriteWords extends StatefulWidget {
  @override
  _FavoriteWordsState createState() => _FavoriteWordsState();
}

class _FavoriteWordsState extends State<FavoriteWords> {
  Future words;

  @override
  void initState() {
    final client = WordDatabase();
    words = client.getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
      future: words,
      builder: (context, wordSnapshot) {
        if (wordSnapshot.connectionState == ConnectionState.done) {
          var words = wordSnapshot.data;
          if (wordSnapshot.hasError) {
            return Center(child: Icon(Icons.error));
          } else {
            if (words == null || words.isEmpty) {
              return Center(
                child: Lottie.asset(Assets.sleeping_cat_anim_path),
              );
            }
            return _buildFavouriteWords(context, words);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildFavouriteWords(BuildContext context, List<Word> words) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      separatorBuilder: (_, index) {
        return Divider(
          indent: 8,
          endIndent: 8,
          color: Colors.black26,
        );
      },
      itemCount: words.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            decoration: ShapeDecoration(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          key: Key(words[index].id.toString()),
          onDismissed: (direction) {
            print('removing ${words[index].adige} from list');
            _showSnackBar(context, words[index]);
            _deleteFromFavorites(words[index]);
            setState(() {
              words.removeAt(index);
            });
          },
          child: ListTile(
            title: Text(
              words[index].adige,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              words[index].turkish,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.green, size: 28),
              onPressed: () {
                print('removing ${words[index].adige} from list');
                _deleteFromFavorites(words[index]);
                setState(() {
                  words.removeAt(index);
                });
              },
            ),
          ),
        );
      },
    );
  }
}

_showSnackBar(BuildContext context, Word removedWord) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        tr("favourite_words.removing_word") + ": " + removedWord.adige,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "DidactGothic",
        ),
      ),
    ),
  );
}

_deleteFromFavorites(Word word) {
  print('removing ${word.adige} from database');
  WordDatabase wordDatabase = WordDatabase();
  wordDatabase.deleteWord(word.wordId);
}
