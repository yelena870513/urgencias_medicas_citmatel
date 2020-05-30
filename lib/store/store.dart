import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/models/equipo.dart';
import 'package:urgencias_flutter/models/tema.dart';
import 'package:urgencias_flutter/models/question.dart';

class StoreModel extends Model {
  List<Contenido> _contenidos = [];
  List<Tema> _temas = [];
  List<Equipo> _equipos = [];
  List<Question> _questions = [];
  final String _temaPath = 'assets/temas/';
  bool showContenidoScroll = false;

  List<Contenido> get contenidos {
    return List.from(_contenidos);
  }

  List<Tema> get temas {
    return List.from(_temas);
  }

  List<Equipo> get equipos {
    return List.from(_equipos);
  }

  String get pathTema {
    return _temaPath;
  }

  void addContenido(Contenido contenido) {
    _contenidos.add(contenido);
    notifyListeners();
  }

  void addTema(Tema tema) {
    _temas.add(tema);
    notifyListeners();
  }

  void addEquipo(Equipo equipo) {
    _equipos.add(equipo);
    notifyListeners();
  }

  void populateLists(String text) {
    if (text.length > 0) {
      _contenidos.clear();
      _temas.clear();
      _equipos.clear();
      
      final Map<String, dynamic> parsedMap = json.decode(text);
      final List<dynamic> contenidos = parsedMap['contenido'];
      final List<dynamic> temas = parsedMap['tema'];
      final List<dynamic> equipos = parsedMap['creditos'];

      _contenidos = contenidos.map((f) => Contenido.fromJson(f)).toList();
      _contenidos.sort((a, b) => a.orden - a.orden);
      _temas = temas.map((f) => Tema.fromJson(f)).toList();
      _temas.sort((a, b) => a.orden - b.orden);
      _equipos = equipos.map((f) => Equipo.fromJson(f)).toList();

      notifyListeners();
    }
  }

  void loadQuestions(String text)
  {
    if (text.length > 0) {
      _questions.clear();
      final List<dynamic> parsedMap = json.decode(text)['preguntas'];
      _questions = parsedMap.map((f) => Question.fromJson(f)).toList();
      
    }

  }

  int getTemasCount(Tema tema)
  {
    return _contenidos.where((Contenido contenido) => contenido.tema.id == tema.id).length;
  }

  int getContenidos()
  {
    return _contenidos.length;
  }

  void toggleContenidoScroll(showScroll) {
    showContenidoScroll = showScroll;
    notifyListeners();
  }
}