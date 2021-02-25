import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/question.dart';
import 'package:urgencias_flutter/models/question_option.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';
import 'package:urgencias_flutter/widgets/radio_question_widget.dart';
import 'package:urgencias_flutter/store/store.dart';

class QuestionWidget extends StatelessWidget {
  final int questionId;
  QuestionWidget(this.questionId);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      Question question =
          model.questions.firstWhere((Question q) => q.id == questionId);
      return _buildQuestion(context, question, model);
    });
  }

  Widget _buildQuestion(
      BuildContext context, Question question, StoreModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            question.header,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: model.isQuestionLocked(questionId)
                    ? ListAppTheme.nearlyGreen
                    : Colors.black,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: _getAvailableImage(question),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getQuestionOptionList(question),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getQuestionOptionList(Question question) {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 1;
    for (int i = 0; i < question.questionOption.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final QuestionOption questionOption = question.questionOption[count];
          listUI.add(RadioQuestionWidget(questionId, questionOption.id));
          count += 1;
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget _getAvailableImage(Question question) {
    Widget imageSize = Text('Image');
    if (question.image.isNotEmpty) {
      imageSize = Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Image.asset(
          'assets/images/img/' + question.image
        ),
      );
    }

    return imageSize;
  }
}
