import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/models/tema.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:urgencias_flutter/urgencias/image_screen.dart';
import 'package:urgencias_flutter/widgets/home_named_button_link.dart';

class ContenidoView extends StatefulWidget {
  final int contenidoId;
  ContenidoView(this.contenidoId);
  @override
  _ContenidoViewState createState() => _ContenidoViewState();
}

class _ContenidoViewState extends State<ContenidoView>
    with TickerProviderStateMixin {
  final double infoHeight = 400.0;
  AnimationController animationController;
  ScrollController _scrollController = new ScrollController();
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  Size _mediaQuery;
  bool isFavoriteTapped = false;
  bool isHomeTapped = false;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
    handleScroll();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  void showScrollButton() {}

  void hideScrollButton() {}

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_mediaQuery.width > 375.0) {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          showScrollButton();
        }

        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          hideScrollButton();
        }
      }
    });
  }

  void _openImageScreen(BuildContext context, String image) {
    Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (context, animation1, animation2) {
      return FadeTransition(
        opacity: animation1,
        child: ImageScreen(image),
      );
    }));
  }

  void _zoomInFavorite() {
    setState(() {
      isFavoriteTapped = true;
    });
  }

  void _zoomOutFavorite() {
    setState(() {
      isFavoriteTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.7) +
        50.0;
    setState(() {
      _mediaQuery = MediaQuery.of(context).size;
    });
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      Contenido reader = model.contenidos
          .firstWhere((Contenido f) => f.id == widget.contenidoId);
      Tema tema = model.temas.firstWhere((Tema f) => f.id == reader.tema.id);
      model.addHistorical(reader);
      return WillPopScope(
        child: Container(
          color: ListAppTheme.nearlyWhite,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 45.0),
                      child: AspectRatio(
                        aspectRatio: 2.8,
                        child: Image.asset(
                          'assets/temas/' + tema.image,
                          width: _mediaQuery.width * 0.15,
                          height: _mediaQuery.height * 0.15,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.7) - 50.0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ListAppTheme.nearlyWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: ListAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: infoHeight,
                              maxHeight: tempHeight > infoHeight
                                  ? tempHeight
                                  : infoHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, left: 18, right: 16),
                                child: Text(
                                  reader.titulo,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: ListAppTheme.darkerText,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 0),
                                    child: SingleChildScrollView(
                                      controller: _scrollController,
                                      child: Html(
                                        data: model.liteSearch(reader.texto),
                                        onImageTap: (src) {
                                          final List<String> pathElements =
                                              src.split(':');
                                          _openImageScreen(
                                              context, pathElements[1]);
                                        },
                                        onImageError: (exception, stackTrace) {
                                          print(exception);
                                        },
                                        shrinkWrap: true,
                                        style: {
                                          "span": Style(
                                              color: ListAppTheme.nearlyGreen,
                                              fontSize: FontSize(
                                                  ScreenUtil().setSp(24)),
                                              fontStyle: FontStyle.italic,
                                              textDecoration:
                                                  TextDecoration.underline),
                                          "u": Style(
                                              color: ListAppTheme.nearlyGreen),
                                          "p": Style(
                                              color: ListAppTheme.body1.color,
                                              fontSize: FontSize(
                                                  ScreenUtil().setSp(22))),
                                          "strong": Style(
                                              color: ListAppTheme.body1.color,
                                              fontSize: FontSize(
                                                  ScreenUtil().setSp(23))),
                                          "i": Style(
                                              color: ListAppTheme.body1.color,
                                              fontSize: FontSize(
                                                  ScreenUtil().setSp(22))),
                                          "b": Style(
                                              color: ListAppTheme.body1.color,
                                              fontSize: FontSize(
                                                  ScreenUtil().setSp(22))),
                                          "h4": Style(
                                              color: ListAppTheme.body1.color,
                                              fontSize: FontSize(
                                                  ScreenUtil().setSp(28))),
                                          "h3": Style(
                                              color: ListAppTheme.body1.color,
                                              fontSize: FontSize(
                                                  ScreenUtil().setSp(29))),
                                          "h5": Style(
                                              color: ListAppTheme.body1.color,
                                              fontSize: FontSize(
                                                  ScreenUtil().setSp(27)))
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).padding.bottom,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.7) - 50.0 - 35,
                  right: 35,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: CurvedAnimation(
                        parent: animationController,
                        curve: Curves.fastOutSlowIn),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 10.0,
                      child: HomeNamedButtonLink(),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.7) - 50.0 - 35,
                  left: 35,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: CurvedAnimation(
                        parent: animationController,
                        curve: Curves.fastOutSlowIn),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 10.0,
                      child: AnimatedContainer(
                        width: isFavoriteTapped ? 120 : 60,
                        height: isFavoriteTapped ? 120 : 60,
                        duration: Duration(seconds: 2),
                        curve: Curves.ease,
                        child: Center(
                            child: InkWell(
                          child: Icon(
                            model.isFavorite(reader.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: ListAppTheme.nearlyGreen,
                            size: 32,
                          ),
                          onTap: () async {
                            _zoomInFavorite();
                            await Future<dynamic>.delayed(
                                const Duration(milliseconds: 200));
                            _zoomOutFavorite();
                            model.addFavorite(reader.id);
                          },
                        )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: ListAppTheme.nearlyBlack,
                        ),
                        onTap: () {
                          model.commit();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton: Visibility(
              visible: false,
              child: FloatingActionButton(
                  child: Icon(Icons.arrow_upward),
                  backgroundColor: Colors.lightBlue.withOpacity(0.5),
                  onPressed: () {
                    _scrollController.jumpTo(0.0);
                    hideScrollButton();
                  }),
            ),
          ),
        ),
        onWillPop: () {
          model.commit();
          Navigator.pop(context, false);
          return Future.value(false);
        },
      );
    });
  }
}
