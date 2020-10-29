import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/question.dart';
import 'package:urgencias_flutter/models/question_option.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';

class RadioQuestionWidget extends StatelessWidget {
  final int questionId;
  final String questionOptionId;
  RadioQuestionWidget(this.questionId, this.questionOptionId);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      QuestionOption questionOption = model.questions
          .firstWhere((Question q) => q.id == questionId)
          .questionOption
          .firstWhere(
              (QuestionOption qo) => qo.id.compareTo(questionOptionId) == 0);
      return _buildRadioQuestion(context, questionOption, model);
    });
  }

  Widget _buildRadioQuestion(
      BuildContext context, QuestionOption questionOption, StoreModel model) {
    double cWidth = MediaQuery.of(context).size.width * 0.6;
    return Expanded(
      child: Row(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              onTap: () {
                if (!model.isQuestionLocked(questionId)) {
                  bool value = !questionOption.isSelected;
                  model.setSelectedQuestionOption(questionOption, value);
                  questionOption.isSelected = value;
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      questionOption.isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: questionOption.isSelected
                          ? ListAppTheme.nearlyGreen
                          : Colors.grey.withOpacity(0.6),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      width: cWidth,
                      child: Text(
                        questionOption.text,
                        softWrap: true,
                        style: model.getQuestionStyle(questionOption),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
