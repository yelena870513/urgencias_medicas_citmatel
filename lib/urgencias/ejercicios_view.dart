import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/popular_filter_list.dart';
import 'package:urgencias_flutter/models/question.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/theme/hotel_app_theme.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';
import 'package:urgencias_flutter/widgets/question_widget.dart';

class EjerciciosScreen extends StatefulWidget {
  @override
  _EjerciciosScreenState createState() => _EjerciciosScreenState();
}

class _EjerciciosScreenState extends State<EjerciciosScreen> {
  List<PopularFilterListData> popularFilterListData =
      PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData =
      PopularFilterListData.accomodationList;

  double distValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      return questionsBuilder(model);
    });
  }

  Widget questionsBuilder(StoreModel model) {
    return WillPopScope(
        child: Container(
          color: HotelAppTheme.buildLightTheme().backgroundColor,
          child: buildScaffold(model),
        ),
        onWillPop: () {
          model.clearAnswers();
          Navigator.pop(context, false);
          return Future.value(false);
        });
  }

  Widget buildScaffold(StoreModel model) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          getAppBarUI(model),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: getQuestionList(model.questions),
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: ListAppTheme.nearlyBlue,
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    model.toggleAnswers();
                  },
                  child: Center(
                    child: Text(
                      'Comprobar respuestas',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getQuestionList(List<Question> questionList) {
    final List<Widget> widgetList = <Widget>[];
    for (int i = 0; i < questionList.length; i++) {
      widgetList.add(QuestionWidget(questionList[i].id));
      if (i < questionList.length - 1) {
        widgetList.add(const Divider(
          height: 1,
        ));
      }
    }
    return widgetList;
  }

  Widget getAppBarUI(StoreModel model) {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    model.clearAnswers();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Ejercicios',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
