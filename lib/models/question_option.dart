import 'package:flutter/material.dart';

class QuestionOption {
  String id;
  String text;
  bool value;
  bool isSelected;

  QuestionOption({
    @required this.id,
    @required this.text,
    @required this.value,
    @required this.isSelected,
  });

  factory QuestionOption.fromJson(Map<String, dynamic> questionOption) {
    return QuestionOption(
        id: questionOption['id'],
        text: questionOption['text'],
        value: questionOption['value'],
        isSelected: false);
  }
}
