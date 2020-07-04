import 'package:flutter/material.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';

class SearchAppBarUIWidget extends StatelessWidget {
  final StoreModel model;
  SearchAppBarUIWidget(this.model);
  @override
  Widget build(BuildContext context) {
    return getAppBarUI(context, model);
  }

  Widget getAppBarUI(BuildContext context, StoreModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: ListAppTheme.nearlyBlack,
                  ),
                  onTap: () {
                    model.clearSearchResults();
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Búsqueda Temática',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: ListAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/logos/urgencias.png'),
          )
        ],
      ),
    );
  }
}
