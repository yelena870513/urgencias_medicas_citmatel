import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';
import 'package:urgencias_flutter/store/store.dart';

class SearchResultContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      return getResultContent(model);
    });
  }

  Widget getResultContent(StoreModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contenidos',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: ListAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}
