import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/models/tema.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';
import 'package:urgencias_flutter/store/store.dart';

class TemasView extends StatefulWidget {
  final int temaIndex;
  final _prefix = 'assets/temas/';
  final _logos = 'assets/logos/';
  TemasView(this.temaIndex);
  @override
  _TemasViewState createState() => _TemasViewState();
}

class _TemasViewState extends State<TemasView> with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      Tema tema = model.temas.elementAt(widget.temaIndex);
      List<Contenido> contenidos =
          model.contenidos.where((c) => c.tema.id == tema.id).toList();
      return Container(
        color: ListAppTheme.nearlyWhite,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.asset(widget._prefix + tema.image),
                  ),
                ],
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
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
                                tema.titulo,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: ListAppTheme.darkerText,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 8, top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          contenidos.length.toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: ListAppTheme.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.bookmark_border,
                                          color: ListAppTheme.nearlyBlue,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Container(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          getTimeBoxUI(
                                              '', contenidos[index], model),
                                  itemCount: contenidos.length,
                                ),
                              ),
                            )),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                right: 35,
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: CurvedAnimation(
                      parent: animationController, curve: Curves.fastOutSlowIn),
                  child: Card(
                    color: Colors.lightBlue.withGreen(5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    elevation: 10.0,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Center(
                          child: Image.asset(
                        widget._logos + tema.image,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
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
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: ListAppTheme.nearlyBlack,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget getTimeBoxUI(String text1, Contenido contenido, StoreModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ListAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: ListAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ListAppTheme.nearlyBlue,
                ),
              ),
              InkWell(
                child: Text(
                  contenido.titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                    letterSpacing: 0.27,
                    color: ListAppTheme.grey,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, '/contenido/' + contenido.id.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
