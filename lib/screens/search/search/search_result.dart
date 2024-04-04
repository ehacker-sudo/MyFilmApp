import 'package:myfilmapp/model/film.dart';

enum SearchResultKind { noTerm, empty, populated }

class SearchResult {
  final SearchResultKind kind;
  // final List<SearchResultItem> items;
  final List<Film> items;

  SearchResult(this.kind, this.items);

  // factory SearchResult.noTerm() =>
  //     SearchResult(SearchResultKind.noTerm, <SearchResultItem>[]);
  factory SearchResult.noTerm() =>
      SearchResult(SearchResultKind.noTerm, <Film>[]);

  factory SearchResult.fromJson(List<Map<String, dynamic>> list) {
    // final items = [for (final item in list) SearchResultItem.fromJson(item)];
    final items = [for (final item in list) Film.fromJson(item)];

    return SearchResult(
      items.isEmpty ? SearchResultKind.empty : SearchResultKind.populated,
      items,
    );
  }

  bool get isPopulated => kind == SearchResultKind.populated;

  bool get isEmpty => kind == SearchResultKind.empty;

  bool get isNoTerm => kind == SearchResultKind.noTerm;
}
