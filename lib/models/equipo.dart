import 'package:flutter/material.dart';

class Equipo {
  int id;
  String name;
  String cargo;
  String tipo;
  String subject;
  String body;
  String pic;
  String tag;
  int order;

  Equipo(
      {@required this.id,
      @required this.name,
      this.cargo,
      this.tipo,
      this.body,
      this.order,
      this.pic,
      this.tag});

  factory Equipo.fromJson(Map<String, dynamic> equipo) {
    return Equipo(
      id: equipo['id'],
      name: equipo['name'],
      cargo: equipo['cargo'],
      order: equipo['order'],
      body: equipo['body'],
      pic: equipo['pic'],
      tag: equipo['tag'],
    );
  }
}
