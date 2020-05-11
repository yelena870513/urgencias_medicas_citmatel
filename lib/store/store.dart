import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/models/equipo.dart';
import 'package:urgencias_flutter/models/tema.dart';

class Store extends Model {
  List<Contenido> _contenidos = [];
  List<Tema> _temas = [];
  List<Equipo> _equipos = [];

  List<Contenido> get contenidos {
    return List.from(_contenidos);
  }

  List<Tema> get temas {
    return List.from(_temas);
  }

  List<Equipo> get equipos {
    return List.from(_equipos);
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
      final parsedMap = json.decode(text).cast<Map<String, dynamic>>();
      final List<Map<String, dynamic>> contenidos = parsedMap['contenido'];
      final List<Map<String, dynamic>> temas = parsedMap['tema'];
      final List<Map<String, dynamic>> equipos = parsedMap['creditos'];
      // load contenido
      contenidos.forEach((c) => {
        _contenidos.add(Contenido(
          id: int.parse(c['id']),
          titulo: c['titulo'],
          orden: int.parse(c['orden']),
          texto: c['texto'],
          tema: Tema(
            orden: c['tema']['orden'],
            id: c['tema']['id'],
            titulo: c['tema']['titulo'],
            )
        ))
      });

      for (var item in temas) {
        _temas.add(Tema(
          id: int.parse(item['id']),
          titulo: item['titulo'],
          image: item['img'],
          orden: int.parse(item['orden'])
        ));
      }

      _equipos = equipos.map((Map<String,dynamic> l) {
        return Equipo(name: l['name']);
      });    
    }
  }
}