import 'package:danef_dictionary/config/assets.dart';
import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';

class FavoriteWords extends StatefulWidget {
  @override
  _FavoriteWordsState createState() => _FavoriteWordsState();
}

class _FavoriteWordsState extends State<FavoriteWords> {
  Future words;

  FluttieAnimationController _sleepingCatAnim;
  bool _animationReady = false;

  @override
  void initState() {
    _prepareAnimation();
    var client = WordDatabase();
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
            if (words == null) {
              return Center(
                child: _animationReady ?
                          FluttieAnimation(
                            _sleepingCatAnim,
                            size: Size(300, 250),
                          ) :
                          Container()
              );
            }
            return _buildFavouriteWords(words);
          }
        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );
  }

  _prepareAnimation() async {
    final instance = Fluttie();
    final sleepingCatComp =
      await instance.loadAnimationFromAsset(Assets.sleeping_cat_anim_path);
    _sleepingCatAnim = await instance.prepareAnimation(
      sleepingCatComp,
      repeatMode: RepeatMode.START_OVER,
    );
    if (mounted) {
      setState(() {
        _animationReady = true;
        _sleepingCatAnim.start();
      });
    }
  }
}

Widget _buildFavouriteWords(List<Word> words) {
  return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: words.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            words[index].adige,
            style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
          ),
          trailing: IconButton(
            icon: Icon(Icons.favorite),
          ),
        );
      });
}


