import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/theme/app_theme.dart';
import 'package:urgencias_flutter/urgencias/autor_view.dart';
import 'package:urgencias_flutter/urgencias/contenido_view.dart';
import 'package:urgencias_flutter/urgencias/creditos_view.dart';
import 'package:urgencias_flutter/urgencias/hotel_home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/urgencias/splash_screen.dart';
import 'package:urgencias_flutter/urgencias/temas_view.dart';

import 'models/tema.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  final StoreModel model = StoreModel();
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  MaterialApp _buildMaterialApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Urgencias Médicas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: SplashScreen(widget.model),
      routes: {
        '/home': (BuildContext context) => HotelHomeScreen(widget.model),
        '/credits': (BuildContext context) => CreditosView(),
        '/author': (BuildContext context) => AutorView(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'tema') {
          final int index = int.parse(pathElements[2]);
          Tema tema = widget.model.temas.elementAt(index);
          int contentAmount = widget.model.getTemasCount(tema);
          if (contentAmount == 1) {
            Contenido contenido = widget.model.contenidos.firstWhere((Contenido f) => f.tema.id == tema.id );
            if (contenido != null) {
              return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ContenidoView(contenido.id));
            }
            
          }
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => TemasView(index));
        }

        if (pathElements[1] == 'contenido') {
          final int contenidoIndex = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ContenidoView(contenidoIndex));
        }

        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => HotelHomeScreen(widget.model));
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StoreModel>(
      child: _buildMaterialApp(),
      model: widget.model,
    );
  }
}
