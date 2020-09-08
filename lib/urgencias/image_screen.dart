import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/galleryItem.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/theme/hotel_app_theme.dart';

class ImageScreen extends StatefulWidget {
  final String imagePath;
  ImageScreen(this.imagePath);
  @override
  State<StatefulWidget> createState() {
    return _ImageScreenState();
  }
}

class _ImageScreenState extends State<ImageScreen> {
  final PageController _pageController = PageController();
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
    final List<String> gallery = [widget.imagePath];
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, StoreModel model) {
      GalleryItem galleryItem = model.gallery.firstWhere(
          (GalleryItem g) => widget.imagePath.indexOf(g.file) != -1);
      String caption = galleryItem != null ? galleryItem.caption : '';
      return Scaffold(
          backgroundColor: HotelAppTheme.buildLightTheme().backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: HotelAppTheme.buildLightTheme().backgroundColor,
            title: Text(
              'Urgencias Médicas',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: BackButton(
              color: Colors.black,
            ),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.5,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Container(
                          color:
                              HotelAppTheme.buildLightTheme().backgroundColor,
                        )),
                        _buildCarousel(gallery),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Text(caption,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            softWrap: true),
                        width: size.width * 0.8,
                      )
                    ],
                  )
                ],
              ))
            ],
          ));
    });
  }

  Widget _buildCarousel(List<String> gallery) {
    return PageView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: PhotoView(
            imageProvider: AssetImage(gallery[index]),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().backgroundColor,
            ),
          ),
          width: 200,
          height: 200,
        );
      },
      itemCount: gallery.length,
      controller: _pageController,
    );
  }
}
