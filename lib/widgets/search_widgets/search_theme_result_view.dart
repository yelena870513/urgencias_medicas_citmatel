import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/tema.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/theme/hex_color.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';

class SearchThemeResultView extends StatelessWidget {
  final Tema tema;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final _prefix = 'assets/temas/';
  final _transparent = 'assets/temas_transparent/';
  SearchThemeResultView({this.tema, this.animation, this.animationController});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation.value), 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  model.setSelectedUITheme(tema.id);
                },
                child: SizedBox(
                  height: 280,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#F8FAFB'),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  // border: new Border.all(
                                  //     color: DesignCourseAppTheme.notWhite),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, left: 16, right: 16),
                                              child: Text(
                                                tema.titulo,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  letterSpacing: 0.27,
                                                  color:
                                                      ListAppTheme.darkerText,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8,
                                                  left: 16,
                                                  right: 16,
                                                  bottom: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '5 contenidos',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      fontSize: 12,
                                                      letterSpacing: 0.27,
                                                      color: ListAppTheme.grey,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.star,
                                                          color: ListAppTheme
                                                              .nearlyBlue,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 48,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 24, right: 16, left: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: ListAppTheme.grey.withOpacity(0.2),
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 6.0),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.28,
                                  child: Image.asset(
                                      tema.id == model.selectedThemeUI
                                          ? _prefix + tema.image
                                          : _transparent + tema.image)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
