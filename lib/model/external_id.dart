class ExternalId {
  final int id;
  final String imdbId;
  final String wikidataId;
  final String facebookId;
  final String instagramId;
  final String twitterId;
  final int total;

  ExternalId({
    int? id,
    String? imdbId,
    String? wikidataId,
    String? facebookId,
    String? instagramId,
    String? twitterId,
    int? total,
  })  : id = id ?? 0,
        imdbId = imdbId ?? "",
        facebookId = facebookId ?? "",
        wikidataId = wikidataId ?? "",
        instagramId = instagramId ?? "",
        twitterId = twitterId ?? "",
        total = total ?? 0;

  factory ExternalId.fromJson(Map<String, dynamic> json) {
    int idCount = 0;
    if (json["imdb_id"] != null) {
      idCount += 1;
    }
    if (json["wikidata_id"] != null) {
      idCount += 1;
    }
    if (json["facebook_id"] != null) {
      idCount += 1;
    }
    if (json["instagram_id"] != null) {
      idCount += 1;
    }
    if (json["twitter_id"] != null) {
      idCount += 1;
    }
    return ExternalId(
      id: json["id"] ?? 0,
      imdbId: json["imdb_id"] ?? "",
      wikidataId: json["wikidata_id"] ?? "",
      facebookId: json["facebook_id"] ?? "",
      instagramId: json["instagram_id"] ?? "",
      twitterId: json["twitter_id"] ?? "",
      total: idCount,
    );
  }
}
