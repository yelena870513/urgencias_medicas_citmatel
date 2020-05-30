
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageScreen extends StatefulWidget
{
  final String imagePath;
  ImageScreen(this.imagePath);
  @override
  State<StatefulWidget> createState() {
    return _ImageScreenState();
  }
  
}

class _ImageScreenState extends State<ImageScreen>
{
   @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(tag: 'imageHtml', child: Image.asset(widget.imagePath)),
          ),
          onTap: () => Navigator.pop(context),
      )
    );
  }

}