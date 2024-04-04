import 'search_result.dart';

/// Actions

class FilmAction {
  FilmAction();
}

class FilmEmptyAction {}

class FilmLoadingAction {}

class FilmErrorAction {}

// class FilmResultAction {
//   final FilmResult result;

//   FilmResultAction(this.result);
// }

class SearchAction {
  final String term;

  SearchAction(this.term);
}

class SearchEmptyAction {}

class SearchLoadingAction {}

class SearchErrorAction {}

class SearchResultAction {
  final SearchResult result;

  SearchResultAction(this.result);
}
