import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/widgets/search_widgets/search_app_bar_ui.dart';
import 'package:urgencias_flutter/widgets/search_widgets/search_content_list_view.dart';
import 'package:urgencias_flutter/widgets/search_widgets/search_theme_list_view.dart';

class SearchResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      return Container(
        color: ListAppTheme.nearlyWhite,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              SearchAppBarUIWidget(),
              getCategoryUI(model),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: SearchContentListView(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget getCategoryUI(StoreModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Temas',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: ListAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SearchThemeListView()
      ],
    );
  }
}
