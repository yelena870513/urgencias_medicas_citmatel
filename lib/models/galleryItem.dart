import 'package:flutter/material.dart';

class GalleryItem {
  int id;
  String file;
  String caption;
  GalleryItem({
    @required this.id,
    @required this.file,
    @required this.caption,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> galleryItem) {
    return GalleryItem(
        id: galleryItem['id'],
        file: galleryItem['file'],
        caption: galleryItem['caption']);
  }
}
