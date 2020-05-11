import 'package:flutter/material.dart';
import 'package:urgencias_flutter/models/tema.dart';
class Contenido {
  int id;
  String titulo;
  String texto;
  String image;
  int orden;
  Tema tema;
  Contenido({
    @required this.id,
    @required this.titulo,
    @required this.texto,
    @required this.tema,
    this.orden,
    this.image
  });
}