import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/manager/preference_manager.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/models/equipo.dart';
import 'package:urgencias_flutter/models/question_option.dart';
import 'package:urgencias_flutter/models/search_helper.dart';
import 'package:urgencias_flutter/models/search_index.dart';
import 'package:urgencias_flutter/models/tema.dart';
import 'package:urgencias_flutter/models/question.dart';
import 'package:urgencias_flutter/theme/list_theme.dart';

class StoreModel extends Model {
  List<Contenido> _contenidos = [];
  List<Tema> _temas = [];
  List<Equipo> _equipos = [];
  List<Question> _questions = [];
  final String _temaPath = 'assets/temas/';
  Preferences _appPrefereces = Preferences();
  SearchHelper _searchHelper = SearchHelper();
  Queue<Contenido> _historical = Queue();

  bool showContenidoScroll = false;
  bool showAnswer = false;
  double fontSize = 16;
  double maxFontSize = 19;
  double minFontSize = 12;
  double themeFontSize = 22;
  double maxThemeFontSize = 25;
  double minThemeFontSize = 19;

  List<Contenido> get contenidos {
    return List.from(_contenidos);
  }

  List<Tema> get temas {
    return List.from(_temas);
  }

  List<Equipo> get equipos {
    return List.from(_equipos);
  }

  List<Question> get questions {
    return List.from(_questions);
  }

  List<Contenido> get historical {
    return List.from(_historical);
  }

  String get pathTema {
    return _temaPath;
  }

  String get searchTerm {
    return _searchHelper.searchTerm;
  }

  List<int> get searchResults {
    return _searchHelper.idSearchResults;
  }

  int getTemasCount(Tema tema) {
    return _contenidos
        .where((Contenido contenido) => contenido.tema.id == tema.id)
        .length;
  }

  int getContenidos() {
    return _contenidos.length;
  }

  TextStyle getQuestionStyle(QuestionOption questionOption) {
    if (showAnswer) {
      return questionOption.value
          ? ListAppTheme.questionUnderline
          : ListAppTheme.questionStyle;
    }
    return ListAppTheme.questionStyle;
  }

  List<int> get favorites {
    return _appPrefereces.favorites;
  }

  bool isFavorite(int contenidoId) {
    return favorites.contains(contenidoId);
  }

  int get selectedThemeUI {
    return _searchHelper.selectedThemeId;
  }

  List<int> get idSearchResults {
    return List.from(_searchHelper.idSearchResults);
  }

  List<Contenido> get indexContenido {
    return _contenidos.where((Contenido t) {
      return _searchHelper.indexContenido.contains(t.id);
    }).toList();
  }

  List<Tema> get indexTemas {
    return _temas.where((Tema t) {
      return _searchHelper.indexThemes.contains(t.id);
    }).toList();
  }

  int get searchIndexCount {
    return _searchHelper.searchIndex.length;
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

  void loadQuestions(String text) {
    if (text.length > 0) {
      _questions.clear();
      final List<dynamic> parsedMap = json.decode(text)['preguntas'];
      _questions = parsedMap.map((f) => Question.fromJson(f)).toList();
    }
  }

  void toggleContenidoScroll(showScroll) {
    showContenidoScroll = showScroll;
    notifyListeners();
  }

  void setSelectedQuestionOption(QuestionOption questionOption, bool value) {
    if (_questions.length > 0) {
      for (int i = 0; i < _questions.length; i++) {
        Question question = _questions[i];
        List<QuestionOption> questionSet = question.questionOption;
        for (int j = 0; j < questionSet.length; j++) {
          if (questionSet[j].id.compareTo(questionOption.id) == 0) {
            _questions[i].questionOption[j].isSelected = value;
            notifyListeners();
            break;
          }
        }
      }
    }
  }

  void clearAnswers() {
    if (_questions.length > 0) {
      for (int i = 0; i < _questions.length; i++) {
        Question question = _questions[i];
        List<QuestionOption> questionSet = question.questionOption;
        for (int j = 0; j < questionSet.length; j++) {
          _questions[i].questionOption[j].isSelected = false;
        }
      }
      notifyListeners();
    }
  }

  void toggleAnswers() {
    showAnswer = !showAnswer;
    notifyListeners();
  }

  void increaseRegularFontSize() {
    if (fontSize < maxFontSize) {
      fontSize++;
      notifyListeners();
    }
  }

  void decreaseRegularFontSize() {
    if (fontSize > minFontSize) {
      fontSize--;
      notifyListeners();
    }
  }

  void setRegularFontSize(double pfontSize) {
    if (pfontSize < maxFontSize) {
      fontSize = pfontSize;
      notifyListeners();
    }
  }

  void increaseThemeFontSize() {
    if (themeFontSize < maxThemeFontSize) {
      themeFontSize++;
      notifyListeners();
    }
  }

  void decreaseThemeFontSize() {
    if (themeFontSize > minThemeFontSize) {
      themeFontSize--;
      notifyListeners();
    }
  }

  void setThemeFontSize(double fontSize) {
    if (fontSize < maxThemeFontSize) {
      themeFontSize = fontSize;
      notifyListeners();
    }
  }

  void setPreferences() {
    _appPrefereces.init().then((value) {
      _appPrefereces = value;
    });
  }

  void addFavorite(int contenidoId) {
    _appPrefereces.addFavorite(contenidoId);
    notifyListeners();
  }

  void removeFavorite(int contenidoId) {
    _appPrefereces.removeFavorite(contenidoId);
    notifyListeners();
  }

  void commit() {
    _appPrefereces.commit();
  }

  void setSearchResults(List<int> results) {
    _searchHelper.setSearchResults(results);
    notifyListeners();
  }

  void addSearchResults(int contenidoId) {
    _searchHelper.addSearchResult(contenidoId);
    notifyListeners();
  }

  void clearSearchResults() {
    _searchHelper.clearSearchResults();
    notifyListeners();
  }

  void setSearchString(String term) {
    _searchHelper.setSearchTerm(term);
  }

  void setSelectedUITheme(int themeId) {
    _searchHelper.setThemeId(themeId);
    notifyListeners();
  }

  void buildSearchIndex() {
    if (_searchHelper.searchTerm.length > 3) {
      List<String> terms =
          _searchHelper.searchTerm.split(' ').where((String t) {
        return t.isNotEmpty;
      }).map((String t) {
        return t
            .toLowerCase()
            .replaceAll('á', 'a')
            .replaceAll('á', 'a')
            .replaceAll('í', 'i')
            .replaceAll('ó', 'o')
            .replaceAll('ú', 'u');
      }).toList();

      _contenidos.forEach((Contenido c) {
        final String texto =
            c.texto.replaceAll(new RegExp(r"/<\/?[^>]+(>|$)/g"), ' ');
        terms.forEach((String f) {
          if (texto.contains(f)) {
            _searchHelper.addSearchIndex(SearchIndex(c.id, c.tema.id));
          }
        });
      });
      notifyListeners();
    }
  }

  void addHistorical(Contenido contenido) {
    if (_historical.length == 3) {
      _historical.removeFirst();
    }

    if (!_historical.contains(contenido)) {
      _historical.addLast(contenido);
    }
  }

  String liteSearch(String html) {
    String result = html;
    if (_searchHelper.searchTerm.length > 3) {
      String query = _searchHelper.searchTerm;
      query = query.replaceAll(new RegExp(r'a', caseSensitive: false), '[a|á]');
      query = query.replaceAll(new RegExp(r'e', caseSensitive: false), '[e|é]');
      query = query.replaceAll(new RegExp(r'i', caseSensitive: false), '[i|í]');
      query = query.replaceAll(new RegExp(r'o', caseSensitive: false), '[o|ó]');
      query = query.replaceAll(new RegExp(r'u', caseSensitive: false), '[u|ú]');
      result = html.replaceAllMapped(
        new RegExp(query, caseSensitive: false), 
        (Match m){
          String group = m.group(0);
          return '<span><b><i><u>' + group + '</u></i></b></span>';
        }    
      );

    }
    return result;
  }
}
