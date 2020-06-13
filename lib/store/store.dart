import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:urgencias_flutter/manager/preference_manager.dart';
import 'package:urgencias_flutter/models/contenido.dart';
import 'package:urgencias_flutter/models/equipo.dart';
import 'package:urgencias_flutter/models/question_option.dart';
import 'package:urgencias_flutter/models/search_helper.dart';
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
      fontSize ++;
      notifyListeners();      
    }
  }

  void decreaseRegularFontSize() {
   if (fontSize > minFontSize) {
      fontSize --;
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
    if(themeFontSize < maxThemeFontSize) {
      themeFontSize ++;
      notifyListeners();
    }    
  }

  void decreaseThemeFontSize() {
    if(themeFontSize > minThemeFontSize) {
       themeFontSize --;
       notifyListeners();
    }
  }

  void setThemeFontSize(double fontSize) {
    if(fontSize < maxThemeFontSize) {
      themeFontSize = fontSize;
      notifyListeners();
    }
  }

  void setPreferences() {
    _appPrefereces.init()
      .then((value){
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
}
