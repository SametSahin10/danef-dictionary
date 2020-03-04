import 'dart:convert';
import 'package:danef_dictionary/config/constants.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static Future<List<Word>> retrieveWords() async {
    final url = '${Constants.BASE_URL}${Constants.wordsString}';
    final token = await getTokenFromSharedPrefs();
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    final wordList = WordList.fromJson(json.decode(response.body));
    wordList.words.forEach((word) => print(word.adige));
    return wordList.words;
  }

  static getToken() async {
    const requestContent = {"username": "admin", "password": "trC6&dw4ohM2", "rememberMe": "true"};
    try {
      final url = Constants.BASE_URL + Constants.AUTH_STRING;
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(requestContent));
      if (response.statusCode == HttpStatus.ok) {
        print('Retrieved JWT token succesfully');
        final responseBody = json.decode(response.body);
        final token = responseBody['id_token'];
        await putTokenIntoSharedPrefs(token);
      } else {
        print('Retrieving JWT token failed');
      }
      print('status code ${response.statusCode}');
      print('response body: ${response.body}');
    } catch (e) {
      print('exception occured while retrieving JWT token: ${e.toString()}');
    }
  }

  static putTokenIntoSharedPrefs(String token) async {
    print('putting token into Shared Preferences');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<String> getTokenFromSharedPrefs() async {
    print('putting token into Shared Preferences');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}