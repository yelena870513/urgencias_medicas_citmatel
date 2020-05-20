import 'package:flutter/material.dart';

class Equipo {
  String name;
  String cargo;
  String tipo;
  String subject;
  String body;
  String pic;
  String tag;
  int order;

  Equipo({
    @required this.name,
    this.cargo,
    this.tipo,
    this.body,
    this.order,
    this.pic,
    this.tag
  });

  factory Equipo.fromJson(Map<String, dynamic> equipo) {
    return Equipo(name: equipo['name']);
  }

}