import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';

class WordTile extends StatefulWidget {
  Word word;
  bool isFavourite;

  WordTile(this.word, {this.isFavourite});

  @override
  _WordTileState createState() => _WordTileState();
}

class _WordTileState extends State<WordTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.word.adige,
        style: TextStyle(
            fontSize: 20,
        ),
      ),
      trailing: IconButton(
          icon: widget.isFavourite ?
          Icon(Icons.favorite, color: Colors.green, size: 28) :
          Icon(Icons.favorite_border, color: Colors.green, size: 28),
          onPressed: () {
            setState(() {
              if (widget.isFavourite) {
                _deleteFromFavorites(widget.word);
              } else {
                _addWordToFavorites(widget.word);
              }
              widget.isFavourite = !widget.isFavourite;
            });
          }
      ),
    );
  }
}

_addWordToFavorites(Word word) {
  print('Adding ${word.adige} to favorites');
  WordDatabase wordDatabase = WordDatabase();
  wordDatabase.addWord(word);
}

_deleteFromFavorites(Word word) {
  print('Deleting ${word.adige} from favorites');
  WordDatabase wordDatabase = WordDatabase();
  wordDatabase.deleteWord(word.wordId);
}
