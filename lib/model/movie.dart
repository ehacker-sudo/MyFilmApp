class Movie {
  final int id;
  final String title;
  final String backdropPath;

  const Movie({
    required this.id,
    required this.title,
    required this.backdropPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'backdrop_path': String backdropPath,
      } =>
        Movie(id: id, title: title, backdropPath: backdropPath),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class ListMovie {
  final List<Movie> items;

  const ListMovie(
    this.items,
  );

  factory ListMovie.fromJson(List<Map<String, dynamic>> list) {
    final items = [for (final item in list) Movie.fromJson(item)];

    return ListMovie(
      items,
    );
  }
}
