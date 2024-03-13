class Original {
  final int id;
  final String name;
  final String logoPath;
  final String originCountry;
  final String iso_3166_1;

  Original({
    int? id,
    String? name,
    String? logoPath,
    String? originCountry,
    String? iso_3166_1,
  })  : id = id ?? 0,
        name = name ?? "",
        logoPath = logoPath ?? "",
        originCountry = originCountry ?? "",
        iso_3166_1 = iso_3166_1 ?? "";

  factory Original.fromJson(Map<String, dynamic> json) {
    return Original(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      logoPath: json["logo_path"] ?? "",
      originCountry: json["origin_country"] ?? "",
      iso_3166_1: json["iso_3166_1"] ?? "",
    );
  }
}
