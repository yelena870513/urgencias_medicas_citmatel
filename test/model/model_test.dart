import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/models/equipo.dart';
import 'package:urgencias_flutter/models/tema.dart';

void main() {
  testWidgets('Parse Tema Model', (WidgetTester tester) async {
    String temaString =
        '{ "id": 1, "titulo": "Test tema", "img": "tema.jpg", "order": 1 }';
    Map<String, dynamic> jsonTema = json.decode(temaString);
    Tema tema = Tema.fromJson(jsonTema);
    expect(1, tema.id);
    expect("Test tema", tema.titulo);
  });

  testWidgets('Parse Equipo Model', (WidgetTester tester) async {
    String equipoString =
        '{ "id": 1, "name": "Test tema", "img": "tema.jpg", "order": 1 }';
    Map<String, dynamic> jsonEquipo = json.decode(equipoString);
    Equipo equipo = Equipo.fromJson(jsonEquipo);
    expect(1, equipo.id);
    expect("Test tema", equipo.name);
  });

  testWidgets('Parse Contenido Model', (WidgetTester tester) async {
    String contenidoString =
        '{ "id": 1, "titulo": "Test tema", "texto": "tema.jpg", "order": 1 }';
    Map<String, dynamic> jsonContenido = json.decode(contenidoString);
    Contenido contenido = Contenido.fromJson(jsonContenido);
    expect(1, contenido.id);
    expect("Test tema", contenido.titulo);
  });
}
