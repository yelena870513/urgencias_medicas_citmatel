import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const CONTENT_KEY = "content_id";

  static final Preferences instance = Preferences._internal();
  SharedPreferences _sharedPreferences;
  List<int> _contenidos = List<int>();

  Preferences._internal();
  factory Preferences() => instance;

  Future<SharedPreferences> get preferences async {
    if (_sharedPreferences != null) {
      return _sharedPreferences;
    } else {
      _sharedPreferences = await SharedPreferences.getInstance();
      String ids = _sharedPreferences.getString(CONTENT_KEY);
      if (ids != null && ids.isNotEmpty) {
        _contenidos =
            ids.split(',').map((String part) => int.parse(part)).toList();
      }
      return _sharedPreferences;
    }
  }

  List<int> get favorites {
    return _contenidos;
  }

  int addFavorite(int contenidoId) {
    if (!_contenidos.contains(contenidoId)) {
      _contenidos.add(contenidoId);
      return contenidoId;
    }
    return contenidoId;
  }

  int removeFavorite(int contenidoId) {
    if (_contenidos.contains(contenidoId)) {
      _contenidos.remove(contenidoId);
    }
    return contenidoId;
  }

  Future<bool> commit() async {
    String chain = _contenidos.map((int c) => c.toString()).toList().join(',');
    await _sharedPreferences.setString(CONTENT_KEY, chain);
    return true;
  }

  Future<Preferences> init() async {
    _sharedPreferences = await preferences;
    return this;
  }
}
