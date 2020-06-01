import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/tema.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/theme/hotel_app_theme.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';

class HotelListView extends StatelessWidget {
  const HotelListView(
      {Key key,
      this.tema,
      this.animationController,
      this.animation,
      this.callback,
      this.contenidoCount})
      : super(key: key);

  final VoidCallback callback;
  final Tema tema;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final String prefix = 'assets/temas/';
  final String logos = 'assets/logos/';
  final int contenidoCount;

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
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 16),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    callback();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: const Offset(4, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.asset(
                                  prefix + tema.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: HotelAppTheme.buildLightTheme()
                                    .backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                tema.titulo,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: model.themeFontSize,
                                                ),
                                              ),
                                              buildCounterBox(contenidoCount)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.local_hospital,
                                    color: ListAppTheme.nearlyBlue,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildCounterBox(contenidoCount) {
    if (contenidoCount > 1) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.library_books,
            size: 12,
            color: ListAppTheme.nearlyBlue,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              '${contenidoCount.toString()} contenidos',
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
            ),
          ),
        ],
      );
    }
    return SizedBox(
      height: 1,
    );
  }
}
