import 'package:danef_dictionary/api/network.dart';

const String wordAPIURL = 'https://danef-dictionary-api.herokuapp.com';
const String wordsString = 'words';

class WordAPI {
  Future<dynamic> getWords() async {
    Network network = Network('$wordAPIURL/$wordsString');
    var wordData = await network.getData();
    print(wordData.toString());
    return wordData;
  }
}