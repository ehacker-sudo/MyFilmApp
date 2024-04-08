class Language {
  final String name;
  final String iso_639_1;
  final String englishName;

  Language({
    String? name,
    String? iso_639_1,
    String? englishName,
  })  : name = name ?? "",
        englishName = englishName ?? "",
        iso_639_1 = iso_639_1 ?? "";

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json["name"] ?? "",
      iso_639_1: json["iso_639_1"] ?? "",
      englishName: json["english_name"] ?? "",
    );
  }
}

class ListLanguage {
  final List<Language> items;

  ListLanguage({
    List<Language>? items,
  }) : items = items ?? <Language>[];

  factory ListLanguage.noTerm() => ListLanguage();

  factory ListLanguage.fromJson(
    List<Map<String, dynamic>> list,
  ) {
    final items = [for (final item in list) Language.fromJson(item)];

    return ListLanguage(
      items: items,
    );
  }
}
