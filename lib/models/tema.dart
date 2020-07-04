import 'package:flutter/material.dart';

class Tema {
  int id;
  String titulo;
  String subtitulo;
  String image;
  int orden;
  Tema({
    @required this.id,
    @required this.titulo,
    this.subtitulo,
    this.image,
    this.orden,
  });

  factory Tema.fromJson(Map<String, dynamic> tema) {
    return Tema(
        id: tema['id'],
        titulo: tema['titulo'],
        image: tema['img'],
        orden: tema['orden']);
  }
}
