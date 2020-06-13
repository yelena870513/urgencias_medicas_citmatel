import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/widgets/search_widgets/search_theme_result_view.dart';

class SearchThemeListView extends StatefulWidget {
  _SearchThemeListView createState() => _SearchThemeListView();
}

class _SearchThemeListView extends State<SearchThemeListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Container(
            height: 134,
            width: double.infinity,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = 5 > 10 ? 10 : 5;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return SearchThemeResultView(
                        tema: model.temas[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            )),
      );
    });
  }
}
