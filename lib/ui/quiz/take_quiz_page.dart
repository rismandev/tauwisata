import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tauwisata/common/enum.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/common/sizeconfig.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/data/helper/preferences_helper.dart';
import 'package:tauwisata/data/model/quiz_model.dart';
import 'package:tauwisata/widgets/button/answer.dart';
import 'package:tauwisata/widgets/button/red_primary.dart';

class TakeQuizPage extends StatefulWidget {
  static String routeName = 'take_quiz';

  @override
  _TakeQuizPageState createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  PreferencesHelper _preferencesHelper = PreferencesHelper(
    sharedPreferences: SharedPreferences.getInstance(),
  );
  List<QuizModel> _dataQuiz = List<QuizModel>();
  bool _isAnswered = false;
  int _indexAnswered = 0;
  int _indexQuiz = 0;
  AnswerQuestion _quizResult = AnswerQuestion.DEFAULT;
  List<AnswerQuestion> _listResult = List<AnswerQuestion>();

  Timer _timer;
  int _timerCount = 15;

  @override
  void initState() {
    super.initState();
    _listResult = new List<AnswerQuestion>();
    _startTimer();
  }

  void _startTimer() {
    this._timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (_timerCount == 0) {
        setState(() {
          _isAnswered = true;
        });
        showCustomSnackBar(
          context,
          backgroundColor: primaryRedColor,
          textColor: Colors.white,
          duration: Duration(milliseconds: 800),
          text: 'Waktu kamu habis, pertanyaan ini akan dianggap salah!',
        );
        _timer.cancel();
      } else {
        setState(() {
          _timerCount = this._timerCount - 1;
        });
      }
    });
  }

  @override
  void dispose() {
    this._timer.cancel();
    super.dispose();
  }

  void _actionAnswer(
    bool isAnswered,
    int index,
  ) {
    _timer.cancel();
    AnswerQuestion _quizAnswer =
        isAnswered ? AnswerQuestion.CORRECT : AnswerQuestion.WRONG;
    setState(() {
      _isAnswered = true;
      _indexAnswered = index;
      _timerCount = 0;
      _quizResult = _quizAnswer;
    });
    _listResult.add(_quizAnswer);
    if (isAnswered) {
      showCustomSnackBar(
        context,
        text: "Selamat, Jawaban Kamu Benar!",
        duration: Duration(milliseconds: 800),
        backgroundColor: primaryQuizCorrectColor,
        textColor: Colors.white,
      );
    } else {
      showCustomSnackBar(
        context,
        text: "Maaf, Jawaban Kamu Salah!",
        duration: Duration(milliseconds: 800),
        backgroundColor: primaryRedColor,
        textColor: Colors.white,
      );
    }
  }

  Future<bool> _onBackPressed() async {
    showCustomAlert(
      context,
      title: "Apakah kamu yakin ingin keluar?",
      subtitle:
          "Kamu harus menyelesaikan kuis ini agar hasilnya dapat tersimpan.",
      onConfirm: () => Navigation.back(),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: quizScaffold,
        backgroundColor: primaryGreenColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: -20,
              right: 0,
              child: Image.asset(
                'assets/shapes/shape_bottom.png',
                color: Colors.white,
                width: 235,
                height: 235,
              ),
            ),
            FutureBuilder(
              future: DefaultAssetBundle.of(
                context,
              ).loadString('assets/quiz.json'),
              builder: (context, snapshot) {
                List<QuizModel> questions = parseQuizFromJson(snapshot.data);

                if (_dataQuiz.length == 0) {
                  _dataQuiz = questions;
                }

                if (_dataQuiz.length == 0) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }

                return _buildContent(context, _dataQuiz);
              },
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _buildContent(
    BuildContext context,
    List<QuizModel> questions,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimer(context),
                _buildQuizCount(
                  context,
                  totalCount: questions.length.toString(),
                ),
              ],
            ),
          ),
          _buildQuestion(
            context,
            questionName: questions[_indexQuiz].questionName,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: AnswerButton(
              text: questions[_indexQuiz].answer1.value ?? "",
              disabled: _isAnswered,
              isCorrect:
                  _indexAnswered != 1 ? AnswerQuestion.DEFAULT : _quizResult,
              onPressed: () =>
                  _actionAnswer(questions[_indexQuiz].answer1.isAnswered, 1),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: AnswerButton(
              text: questions[_indexQuiz].answer2.value ?? "",
              disabled: _isAnswered,
              isCorrect:
                  _indexAnswered != 2 ? AnswerQuestion.DEFAULT : _quizResult,
              onPressed: () =>
                  _actionAnswer(questions[_indexQuiz].answer2.isAnswered, 2),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: AnswerButton(
              text: questions[_indexQuiz].answer3.value ?? "",
              disabled: _isAnswered,
              isCorrect:
                  _indexAnswered != 3 ? AnswerQuestion.DEFAULT : _quizResult,
              onPressed: () =>
                  _actionAnswer(questions[_indexQuiz].answer3.isAnswered, 3),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: AnswerButton(
              text: questions[_indexQuiz].answer4.value ?? "",
              disabled: _isAnswered,
              isCorrect:
                  _indexAnswered != 4 ? AnswerQuestion.DEFAULT : _quizResult,
              onPressed: () =>
                  _actionAnswer(questions[_indexQuiz].answer4.isAnswered, 4),
            ),
          ),
          if (this._isAnswered) ...[
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 30, top: 10),
              alignment: Alignment.center,
              child: RedPrimaryButton(
                text: questions.length - 1 == _indexQuiz ? "Selesai" : "Lanjut",
                onPressed: () {
                  if (questions.length - 1 == _indexQuiz) {
                    int _numberOfCorrect = _listResult
                        .where((quiz) => quiz == AnswerQuestion.CORRECT)
                        .length;
                    QuizResult _quizResult = QuizResult(
                      name: "Kuis TauWisata",
                      correct: _numberOfCorrect,
                      wrong: _listResult.length - _numberOfCorrect,
                      dateTime: DateTime.now().toLocal().toString(),
                    );
                    _preferencesHelper.setQuizResult(_quizResult);
                    showCustomAlert(
                      context,
                      title: "Hasil Kuis!",
                      subtitle:
                          "Jawaban kamu yang benar sebanyak $_numberOfCorrect dari ${questions.length} pertanyaan.",
                      callback: () => Navigation.back(),
                    );
                  } else {
                    setState(() {
                      _indexAnswered = 0;
                      _indexQuiz = _indexQuiz + 1;
                      _isAnswered = false;
                      _timerCount = 15;
                      _quizResult = AnswerQuestion.DEFAULT;
                    });
                    _startTimer();
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Container _buildQuestion(
    BuildContext context, {
    String questionName,
  }) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      height: SizeConfig.heightMultiplier * 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryShadowColor.withOpacity(0.30),
            blurRadius: 10,
            offset: Offset.zero,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: Text(
              'Pertanyaan :',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: primaryDarkColor, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text(
                questionName ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: primaryDarkColor, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildQuizCount(
    BuildContext context, {
    String totalCount,
  }) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: primaryRedColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 2,
          style: BorderStyle.solid,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryShadowColor.withOpacity(0.30),
            blurRadius: 10,
            offset: Offset.zero,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        '${_indexQuiz + 1} / $totalCount',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  Container _buildTimer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/icon_alarm.png',
            width: 35,
            height: 35,
          ),
          SizedBox(width: 5),
          Text(
            '$_timerCount',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: primaryRedColor),
          ),
          SizedBox(width: 5),
          Text(
            'Detik',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: primaryDarkColor),
          ),
        ],
      ),
    );
  }
}
