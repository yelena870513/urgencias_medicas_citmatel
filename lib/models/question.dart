import 'package:flutter/material.dart';
import './question_option.dart';

class Question {
  int id;
  String type;
  String header;
  List<QuestionOption> questionOption;
  bool isLocked = false;
  bool isSubmitted = false;

  Question({
    @required this.id,
    @required this.type,
    @required this.header,
    @required this.questionOption,
  });

  factory Question.fromJson(Map<String, dynamic> question) {
    List<dynamic> questionOptions = question['questionSet'];
    return Question(
        id: question['id'],
        type: question['type'],
        header: question['header'],
        questionOption:
            questionOptions.map((f) => QuestionOption.fromJson(f)).toList());
  }
}
