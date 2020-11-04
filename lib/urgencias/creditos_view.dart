import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/equipo.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/widgets/home_button_link.dart';

class CreditosView extends StatefulWidget {
  CreditosView();
  @override
  _CreditosViewState createState() => _CreditosViewState();
}

class _CreditosViewState extends State<CreditosView>
    with TickerProviderStateMixin {
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
      List<Equipo> equipos = model.equipos.where((e) {
        return e.id != 8 && e.id != 9;
      }).toList();
      equipos.sort((e1, e2) => e1.order - e2.order);
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
                    child: Image.asset('assets/images/fondo_creditos.jpg'),
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
                                'Créditos Institucionales',
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
                                    child: SizedBox(),
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
                                          getTimeBoxUI(equipos[index]),
                                  itemCount: equipos.length,
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
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    elevation: 10.0,
                    child: HomeButtonLink(),
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

  Widget getTimeBoxUI(Equipo equipo) {
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
              AutoSizeText(
                equipo.cargo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: ListAppTheme.nearlyGreen,
                ),
              ),
              InkWell(
                child: AutoSizeText(
                  equipo.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 18,
                    letterSpacing: 0.27,
                    color: ListAppTheme.grey,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
