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
      builder: (context, wordSnapshot) {
        if (wordSnapshot.connectionState == ConnectionState.done) {
          if (wordSnapshot.hasError) {
            return Center(child: Icon(Icons.error));
          } else {
            if (wordSnapshot.data == null) {
              return Center(child: Text('Add some words favorites'));
            }
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: wordSnapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    wordSnapshot.data[index].adige,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto'
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
      future: words,
    );
  }
}

