import 'dart:convert';
import 'package:danef_dictionary/config/constants.dart';
import 'package:danef_dictionary/models/word.dart';
//import 'package:flutter_config/flutter_config.dart';
//import 'package:dotenv/dotenv.dart' show env;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static Future<List<Word>> retrieveWords() async {
    final baseUrl = DotEnv().env['BASE_URL'];
    final url = '$baseUrl${Constants.wordsString}';
    final token = await getToken();
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    print('response: ${response.body}');
    final decodedJson = json.decode(utf8.decode(response.bodyBytes));
    final wordList = WordList.fromJson(decodedJson['data']);
    wordList.words.forEach((word) => print(word.adige));
    return wordList.words;
  }

  static Future<List<Word>> retrieveWordsByPattern(String pattern) async {
    final baseUrl = DotEnv().env['BASE_URL'];
    final url = '$baseUrl${Constants.wordsString}'
        '?${Constants.adigeString}'
        '$pattern&'
        '${Constants.turkishString}'
        '$pattern';
    print('retrieving words by pattern. URL: $url');
    final token = await getToken();
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    final decodedJson = json.decode(utf8.decode(response.bodyBytes));
    final wordList = WordList.fromJson(decodedJson['data']);
    wordList.words.forEach((word) => print(word.adige));
    return wordList.words;
  }

  static Future<List<Word>> retrieveTurkishWordsByPattern(
      String pattern) async {
    final baseUrl = DotEnv().env['BASE_URL'];
    final url =
        '$baseUrl${Constants.wordsString}?${Constants.turkishString}$pattern';
    final token = await getToken();
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    final decodedJson = json.decode(utf8.decode(response.bodyBytes));
    final wordList = WordList.fromJson(decodedJson['data']);
    wordList.words.forEach((word) => print(word.turkish));
    return wordList.words;
  }

  static Future<List<Word>> retrieveAdigeWordsByPattern(String pattern) async {
    final baseUrl = DotEnv().env['BASE_URL'];
    final url =
        '$baseUrl${Constants.wordsString}?${Constants.adigeString}$pattern';
    final token = await getToken();
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    final decodedJson = json.decode(utf8.decode(response.bodyBytes));
    final wordList = WordList.fromJson(decodedJson['data']);
    wordList.words.forEach((word) => print(word.adige));
    return wordList.words;
  }

  static Future<String> getToken() async {
    final token = await getTokenFromSharedPrefs();
    if (token == null) await retrieveToken();
    return await getTokenFromSharedPrefs();
  }

  static retrieveToken() async {
    final baseUrl = DotEnv().env['BASE_URL'];
    final username = DotEnv().env['username'];
    final password = DotEnv().env['password'];
    print('baseUrl: $baseUrl');
    print('username: $username');
    print('password: $password');
    final requestBody = {
      "email": "$username",
      "password": "$password",
    };
    try {
      final url = baseUrl + Constants.signInScreen;
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(requestBody),
      );
      if (response.statusCode == HttpStatus.ok) {
        print('Retrieved JWT token succesfully');
        final responseBody = json.decode(response.body);
        final token = responseBody['account']['token'];
        print('token: $token');
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
