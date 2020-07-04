import 'package:flutter/material.dart';
import 'package:urgencias_flutter/models/tema.dart';

class Contenido {
  int id;
  String titulo;
  String texto;
  String image;
  int orden;
  Tema tema;
  Contenido(
      {@required this.id,
      @required this.titulo,
      @required this.texto,
      @required this.tema,
      this.orden,
      this.image});
  factory Contenido.fromJson(Map<String, dynamic> contenido) {
    return Contenido(
        id: contenido['id'],
        titulo: contenido['titulo'],
        orden: contenido['orden'],
        texto: contenido['texto'],
        tema: Tema.fromJson(contenido['tema']));
  }
}
