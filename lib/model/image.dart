class ImageModel {
  final double aspectRatio;
  final int height;
  final String iso_639_1;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  const ImageModel({
    double? aspectRatio,
    int? height,
    String? iso_639_1,
    String? filePath,
    double? voteAverage,
    int? voteCount,
    int? width,
  })  : aspectRatio = aspectRatio ?? 0,
        height = height ?? 0,
        iso_639_1 = iso_639_1 ?? "",
        filePath = filePath ?? "",
        voteAverage = voteAverage ?? 0.0,
        voteCount = voteCount ?? 0,
        width = width ?? 0;

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      aspectRatio: json["aspect_ratio"] ?? 0,
      height: json["height"] ?? 0,
      iso_639_1: json["iso_639_1"] ?? "",
      filePath: json["file_path"] ?? "",
      voteAverage: json["vote_average"] ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
      width: json["width"] ?? 0,
    );
  }
}

class ListImage {
  final List<ImageModel> listBackdrop;
  final List<ImageModel> listLogo;
  final List<ImageModel> listPosters;
  final List<ImageModel> listStills;
  final List<ImageModel> listProfiles;

  const ListImage(
    this.listBackdrop,
    this.listLogo,
    this.listPosters,
    this.listStills,
    this.listProfiles,
  );

  factory ListImage.fromJson(
    List<Map<String, dynamic>> listBackdrop,
    List<Map<String, dynamic>> listLogo,
    List<Map<String, dynamic>> listPosters,
    List<Map<String, dynamic>> listStills,
    List<Map<String, dynamic>> listProfiles,
  ) {
    final backdrops = [
      for (final item in listBackdrop) ImageModel.fromJson(item)
    ];
    final logos = [for (final item in listLogo) ImageModel.fromJson(item)];
    final posters = [for (final item in listPosters) ImageModel.fromJson(item)];
    final stills = [for (final item in listStills) ImageModel.fromJson(item)];
    final profiles = [
      for (final item in listProfiles) ImageModel.fromJson(item)
    ];

    return ListImage(
      backdrops,
      logos,
      posters,
      stills,
      profiles,
    );
  }
}
