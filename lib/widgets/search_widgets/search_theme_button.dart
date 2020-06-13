import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/tema.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';
import 'package:urgencias_flutter/store/store.dart';

class SearchThemeButtonWidget extends StatelessWidget {
  final int temaId;

  SearchThemeButtonWidget(this.temaId);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      Tema tema = model.temas.firstWhere((Tema t) => t.id == temaId);
      return getButtonUI(tema, model);
    });
  }

  Widget getButtonUI(Tema tema, StoreModel model) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: model.selectedThemeUI == tema.id
                ? ListAppTheme.nearlyBlue
                : ListAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: ListAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              model.setSelectedUITheme(tema.id);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  tema.titulo,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: model.selectedThemeUI == tema.id
                        ? ListAppTheme.nearlyWhite
                        : ListAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
