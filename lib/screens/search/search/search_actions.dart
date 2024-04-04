import 'package:myfilmapp/model/film.dart';

/// Actions

// class FilmAction {
//   FilmAction();
// }

// class FilmEmptyAction {}

// class FilmLoadingAction {}

// class FilmErrorAction {}

// class FilmResultAction {
//   final FilmResult result;

//   FilmResultAction(this.result);
// }

class SearchAction {
  final String term;

  SearchAction(this.term);
}

class SearchInitialAction {}

class SearchLoadingAction {}

class SearchErrorAction {}

class SearchResultAction {
  final ListFilm result;

  SearchResultAction(this.result);
}
