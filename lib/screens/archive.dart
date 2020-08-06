import 'package:danef_dictionary/api/api.dart';
import 'package:danef_dictionary/config/assets.dart';
import 'package:danef_dictionary/data/word_database.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:danef_dictionary/widgets/word_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:lottie/lottie.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  Future<List<Word>> _wordsFuture;
  Future<List<Word>> _favoriteWordsFuture;
  var _words = <Word>[];
  WordDatabase _wordDatabase;

  @override
  void initState() {
    _wordsFuture = Api.retrieveWords(offset: "0", limit: "100");
    _wordDatabase = WordDatabase();
    _favoriteWordsFuture = _wordDatabase.getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<List<List<Word>>>(
      future: Future.wait([_wordsFuture, _favoriteWordsFuture]),
      builder: (context, wordSnapshot) {
        if (wordSnapshot.connectionState == ConnectionState.done) {
          _words = wordSnapshot.data[0];
          final favouriteWords = wordSnapshot.data[1];
          if (wordSnapshot.hasError || _words == null) {
            return Center(child: Icon(Icons.error));
          }
          if (_words.isEmpty) {
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
          return ArchiveBody(
            words: _words,
            favouriteWords: favouriteWords,
          );
        } else {
          return Center(
            child: Lottie.asset(Assets.loading_words_anim_path),
          );
        }
      },
    );
  }
}

class ArchiveBody extends StatefulWidget {
  final List<Word> words;
  final List<Word> favouriteWords;

  const ArchiveBody({Key key, this.words, this.favouriteWords})
      : super(key: key);

  @override
  _ArchiveBodyState createState() => _ArchiveBodyState();
}

class _ArchiveBodyState extends State<ArchiveBody> {
  @override
  Widget build(BuildContext context) {
    return LoadMore(
      isFinish: false,
      onLoadMore: () => _onLoadMore(offset: widget.words.length.toString()),
      child: ListView.separated(
        separatorBuilder: (_, index) {
          return Divider(
            indent: 8,
            endIndent: 8,
            color: Colors.black26,
          );
        },
        padding: EdgeInsets.all(8),
        itemCount: widget.words.length,
        itemBuilder: (context, index) {
          return _isInFavorites(widget.favouriteWords, widget.words[index])
              ? WordTile(widget.words[index], isFavourite: true)
              : WordTile(widget.words[index], isFavourite: false);
        },
      ),
      textBuilder: (loadMoreStatus) {
        switch (loadMoreStatus) {
          case LoadMoreStatus.loading:
            return tr("archive.loading");
          case LoadMoreStatus.idle:
            return "Loading words idle";
          case LoadMoreStatus.fail:
            return "Loading words failed";
          case LoadMoreStatus.nomore:
            return "Loading words no more";
          default:
            return "Unknown loading status";
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

  Future<bool> _onLoadMore({@required String offset}) async {
    final newWords = await Api.retrieveWords(offset: offset, limit: "100");
    setState(() {
      widget.words.addAll(newWords);
    });
    return Future.value(true);
  }
}
