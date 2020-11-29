import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tauwisata/data/model/quiz_model.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  static const QUIZ_RESULT = 'QUIZ_RESULT';

  Future<QuizResult> get quizResult async {
    final prefs = await sharedPreferences;
    final _data = prefs.getString(QUIZ_RESULT);
    if (_data != null) {
      Map<String, dynamic> _parsedModel = jsonDecode(_data);
      return QuizResult.fromJson(_parsedModel);
    }
    return null;
  }

  void setQuizResult(QuizResult value) async {
    final prefs = await sharedPreferences;
    Map<String, dynamic> _parsed = value.toJson();
    String _jsonStringify = jsonEncode(_parsed).toString();
    prefs.setString(QUIZ_RESULT, _jsonStringify);
  }

  void deleteQuizResult() async {
    final prefs = await sharedPreferences;
    prefs.remove(QUIZ_RESULT);
  }
}
