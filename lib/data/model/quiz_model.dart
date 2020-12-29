import 'dart:convert';

import 'dart:math';

class QuizResult {
  String name;
  int wrong;
  int correct;
  String dateTime;

  QuizResult({
    this.name,
    this.wrong,
    this.correct,
    this.dateTime,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
        name: json["name"],
        wrong: json["wrong"],
        correct: json["correct"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['wrong'] = wrong;
    data['correct'] = correct;
    data['date_time'] = dateTime;
    return data;
  }
}

class QuizModel {
  String questionName;
  QuizAnswer answer1;
  QuizAnswer answer2;
  QuizAnswer answer3;
  QuizAnswer answer4;

  QuizModel({
    this.questionName,
    this.answer1,
    this.answer2,
    this.answer3,
    this.answer4,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        questionName: json["question_name"],
        answer1: QuizAnswer.fromJson(json["answer_1"]),
        answer2: QuizAnswer.fromJson(json["answer_2"]),
        answer3: QuizAnswer.fromJson(json["answer_3"]),
        answer4: QuizAnswer.fromJson(json["answer_4"]),
      );
}

class QuizAnswer {
  String value;
  bool isAnswered;

  QuizAnswer({
    this.value,
    this.isAnswered = false,
  });

  factory QuizAnswer.fromJson(Map<String, dynamic> json) => QuizAnswer(
        value: json["value"],
        isAnswered: json["is_answered"],
      );
}

List<QuizModel> parseQuizFromJson(String json) {
  if (json == null) {
    return [];
  }

  final _parsed = jsonDecode(json);
  final _random = new Random();

  List<QuizModel> _data = List<QuizModel>();
  List<QuizModel> _randomData = List<QuizModel>();

  _parsed["quiz_data"].forEach((item) {
    _data.add(QuizModel.fromJson(item));
  });

  for (var i = 0; i < 10;) {
    QuizModel _item = _data[_random.nextInt(_data.length)];
    if (!_randomData.contains(_item)) {
      _randomData.add(_item);
      i++;
    }
  }

  return _randomData;
}
