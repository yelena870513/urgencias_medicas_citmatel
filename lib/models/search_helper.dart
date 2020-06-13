class SearchHelper {
  bool _isSearchMode = false;
  List<int> _idSearchResults = new List<int>();
  String _searchTerm = "";
  int _selectedThemeId = 0;

  List<int> get idSearchResults {
    return List.from(_idSearchResults);
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
     if(_idSearchResults.contains(contenidoId)) {
       _idSearchResults.remove(contenidoId);
     }
  }

  void clearSearchResults() {
    _idSearchResults.clear();
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
}