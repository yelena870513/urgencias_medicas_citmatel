
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/models/contenido.dart';

class ContenidoModel extends Model
{
  List<Contenido> _contenidos = [];

   List<Contenido> get contenidos {
    return List.from(_contenidos);
  }

  void addContenido(Contenido contenido) {
    _contenidos.add(contenido);
    notifyListeners();
  }

  void loadContenido(List<dynamic> contenidos)
  {
    _contenidos = contenidos.map((f) => Contenido.fromJson(f)).toList();
    _contenidos.sort((a, b) => a.orden - a.orden);
  }
}