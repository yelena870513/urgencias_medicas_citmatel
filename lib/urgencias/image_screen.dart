import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatefulWidget {
  final String imagePath;
  ImageScreen(this.imagePath);
  @override
  State<StatefulWidget> createState() {
    return _ImageScreenState();
  }
}

class _ImageScreenState extends State<ImageScreen> {
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
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          child: Center(
            child: PhotoView(
              imageProvider: AssetImage(widget.imagePath),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
          onTap: () => Navigator.pop(context),
        ));
  }
}
