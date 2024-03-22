class Person {
  final int id;
  final String name;
  final String imdbId;
  final String birthday;
  final String deathday;
  final String homepage;
  final String profilePath;
  final String placeOfBirth;
  final int gender;
  final String originalName;
  final String character;
  final String mediaType;
  // final List<String> alsoKnownAs;

  final String job;
  final String department;
  final String creditId;
  final String knownForDepartment;
  final String biography;

  Person({
    int? id,
    String? name,
    String? imdbId,
    String? birthday,
    String? deathday,
    String? homepage,
    String? profilePath,
    String? placeOfBirth,
    int? gender,
    String? originalName,
    String? character,
    String? mediaType,
    String? job,
    String? department,
    String? creditId,
    String? knownForDepartment,
    // List<String>? alsoKnownAs,
    String? biography,
  })  : id = id ?? 0,
        name = name ?? "",
        imdbId = imdbId ?? "",
        birthday = birthday ?? "",
        deathday = deathday ?? "",
        homepage = homepage ?? "",
        profilePath = profilePath ?? "",
        placeOfBirth = placeOfBirth ?? "",
        originalName = originalName ?? "",
        character = character ?? "",
        gender = gender ?? 0,
        mediaType = mediaType ?? "person",
        job = job ?? "",
        department = department ?? "",
        creditId = creditId ?? "",
        // alsoKnownAs = alsoKnownAs ?? <String>[],
        knownForDepartment = knownForDepartment ?? "",
        biography = biography ?? "";

  factory Person.fromJson(Map<String, dynamic> json) {
    // List<String> listOtherName = [];
    // if (json['production_countries'] != null) {
    //   listOtherName = [
    //     for (final item in json['production_countries']) Original.fromJson(item)
    //   ];
    // }

    return Person(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      imdbId: json["imdb_id"] ?? "",
      birthday: json["birthday"] ?? "",
      deathday: json["deathday"] ?? "",
      homepage: json["homepage"] ?? "",
      profilePath: json["profile_path"] ?? "",
      placeOfBirth: json["place_of_birth"] ?? "",
      originalName: json["original_name"] ?? "",
      gender: json["gender"] ?? 0,
      character: json["character"] ?? "",
      job: json["job"] ?? "",
      department: json["department"] ?? "",
      creditId: json["credit_id"] ?? "",
      // alsoKnownAs: json["also_known_as"] ?? <String>[],
      knownForDepartment: json["known_for_department"] ?? "",
      biography: json["biography"] ?? "",
    );
  }
}

class ListCredit {
  final List<Person> listCast;
  final List<Person> listCrew;

  const ListCredit(
    this.listCast,
    this.listCrew,
  );

  factory ListCredit.fromJson(
    List<Map<String, dynamic>> listCast,
    List<Map<String, dynamic>> listCrew,
  ) {
    final casts = [for (final item in listCast) Person.fromJson(item)];
    final crews = [for (final item in listCrew) Person.fromJson(item)];

    return ListCredit(
      casts,
      crews,
    );
  }
}
