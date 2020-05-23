import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
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
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/screen.png'),
              fit: BoxFit.cover)),
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue)),
      ),
    );
  }

  void onDoneLoading() {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
