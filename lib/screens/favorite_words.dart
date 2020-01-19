import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';

class FavoriteWords extends StatefulWidget {
  @override
  _FavoriteWordsState createState() => _FavoriteWordsState();
}

class _FavoriteWordsState extends State<FavoriteWords> {
  Future words;

  @override
  void initState() {
    super.initState();
    var client = WordDatabase();
    words = client.getWords();
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
            if (wordSnapshot.data == null) {
              return Center(
                child: Text(
                  'Add some words favorites',
                  style: TextStyle(fontSize: 24),
                )
              );
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
                      fontFamily: 'OpenSans'
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite),
                  ),
                );
              }
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

