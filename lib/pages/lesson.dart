
import 'dart:convert';
import 'package:flutter/material.dart';

import '../widgets/comparision_question.dart';
import '../widgets/single_choice_question.dart';

import '../models/lesson.dart';
import '../models/question.dart';
import '../models/single_choice_question.dart';
import '../models/comparision_question.dart';

class LessonScreen extends StatefulWidget {
  LessonScreen({Key key}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {

  Lesson _lesson;

  int _currentQuestion = -1;

  @override
  void initState() {
    super.initState();

    (() async {
      String data = await DefaultAssetBundle.of(context).loadString("assets/data.json");
      final parsed = json.decode(data).cast<Map<String, dynamic>>();

      final questions = parsed.map<Question>((json) {
        var q = Question.fromJson(json);
        switch (q.type) {
          case "SingleChoiceQuestion":
            return SingleChoiceQuestion.fromJson(json);
          case "ComparisionQuestion":
            return ComparisionQuestion.fromJson(json);
          default:
            return null;
        }
      }).toList();

      print(questions);

      setState(() {
        _lesson = new Lesson(id: 1, questions: questions);
        _currentQuestion = 0;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    Widget w = _renderQuestion();

    return Scaffold(
      body: Container(
        child: w,
      )
    );
  }

  _renderQuestion() {
    if (_currentQuestion < 0) {
      // Loading lesson
      return Container();
    }

    var question = _lesson.questions[_currentQuestion];

    switch (question.type) {
      case "SingleChoiceQuestion":
        return SingleChoiceQuestionWidget(
          question: question,
          onAnswer: _anwser,
          onNext: _next,
        );
      case "ComparisionQuestion":
        return ComparisionQuestionWidget(
          question: question,
          onAnswer: _anwser,
          onNext: _next,
        );
      default:
        return Container();
    }
  }

  _anwser(isCorrect) {
  }

  _next() {
    if (_currentQuestion >= _lesson.questions.length-1) {
      Navigator.pushNamed(context, "/");
    } else {
      setState(() {
        _currentQuestion++;
      });
    }
  }
}
