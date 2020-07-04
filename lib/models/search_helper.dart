import 'package:urgencias_flutter/models/search_index.dart';

class SearchHelper {
  bool _isSearchMode = false;
  List<int> _idSearchResults = new List<int>();
  List<SearchIndex> _searchIndex = new List<SearchIndex>();
  String _searchTerm = "";
  int _selectedThemeId = 0;

  List<int> get idSearchResults {
    return List.from(_idSearchResults);
  }

  List<SearchIndex> get searchIndex {
    return List.from(_searchIndex);
  }

  List<int> get indexThemes {
    return _searchIndex
        .map((SearchIndex s) {
          return s.temaId;
        })
        .toSet()
        .toList();
  }

  List<int> get indexContenido {
    return _searchIndex
        .map((SearchIndex s) {
          return s.contenidoId;
        })
        .toSet()
        .toList();
  }

  bool get isSearchMode {
    return _isSearchMode;
  }

  String get searchTerm {
    return _searchTerm;
  }

  int get selectedThemeId {
    return _selectedThemeId;
  }

  void addSearchResult(int contenidoId) {
    if (!_idSearchResults.contains(contenidoId)) {
      _idSearchResults.add(contenidoId);
    }
  }

  void removeSearchResults(int contenidoId) {
    if (_idSearchResults.contains(contenidoId)) {
      _idSearchResults.remove(contenidoId);
    }
  }

  void clearSearchResults() {
    _idSearchResults.clear();
    _searchIndex.clear();
    setSearchTerm('');
  }

  void setSearchResults(List<int> results) {
    _idSearchResults = results;
  }

  void setSearchTerm(String term) {
    _searchTerm = term;
  }

  void setThemeId(int themeId) {
    _selectedThemeId = themeId;
  }

  void addSearchIndex(SearchIndex searchIndex) {
    if (!_searchIndex.contains(searchIndex)) {
      _searchIndex.add(searchIndex);
    }
  }

  void removeSearchIndex(SearchIndex searchIndex) {
    if (_searchIndex.contains(searchIndex)) {
      _searchIndex.remove(searchIndex);
    }
  }

  void clearSearchIndex() {
    _searchIndex.clear();
  }
}
