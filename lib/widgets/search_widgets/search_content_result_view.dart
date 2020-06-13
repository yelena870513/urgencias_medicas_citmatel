import 'package:flutter/material.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/theme/hex_color.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';

class SearchContentResultView extends StatelessWidget {
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final Contenido contenido;

  const SearchContentResultView(
      {Key key, this.animationController, this.animation, this.contenido})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.3;
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
              onTap: () {},
              child: SizedBox(
                height: 150,
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
                                            child: SizedBox(
                                                width: cWidth,
                                                child: Text(
                                                  contenido.tema.titulo,
                                                  textAlign: TextAlign.left,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    letterSpacing: 0.27,
                                                    color:
                                                        ListAppTheme.darkerText,
                                                  ),
                                                )),
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
                                                SizedBox(
                                                    width: cWidth,
                                                    child: Text(
                                                      contenido.titulo,
                                                      softWrap: true,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 12,
                                                        letterSpacing: 0.27,
                                                        color:
                                                            ListAppTheme.grey,
                                                      ),
                                                    )),
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
                            height: 20,
                          ),
                        ],
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
  }
}
