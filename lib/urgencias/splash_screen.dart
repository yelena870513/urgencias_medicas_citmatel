import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/screenutil.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/store/store.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final StoreModel model;
  SplashScreen(this.model);
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    String questions = await loadQuestion();
    widget.model.loadQuestions(questions);
    String content = await dataText();
    String gallery = await dataGallery();
    widget.model.setPreferences();
    widget.model.populateLists(content);
    widget.model.populateGallery(gallery);
    return new Timer(Duration(microseconds: 300), onDoneLoading);
  }

  Future<String> loadQuestion() async {
    String text = await rootBundle.loadString('assets/data/preguntas.json');
    return text;
  }

  Future<String> dataText() async {
    String text =
        await rootBundle.loadString('assets/data/multimedia.content.json');
    return text;
  }

  Future<String> dataGallery() async {
    String gallery = await rootBundle.loadString('assets/data/gallery.json');
    return gallery;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context, allowFontScaling: false, designSize: size);
    return ScopedModelDescendant<StoreModel>(
        builder: (BuildContext context, Widget child, StoreModel model) {
      return buildSplash(model);
    });
  }

  void onDoneLoading() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  Widget buildSplash(StoreModel model) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/screen.jpg'),
              fit: BoxFit.cover)),
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen)),
      ),
    );
  }
}
