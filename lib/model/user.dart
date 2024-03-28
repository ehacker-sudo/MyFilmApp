class User {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  final String username;
  final String avatarPath;
  final double rating;

  User({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? username,
    String? avatarPath,
    double? rating,
  })  : name = name ?? "",
        email = email ?? "",
        password = password ?? "",
        confirmPassword = confirmPassword ?? "",
        username = username ?? "",
        avatarPath = avatarPath ?? "",
        rating = rating ?? 0.0;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      confirmPassword: json["confirm_password"] ?? "",
      username: json["username"] ?? "",
      avatarPath: json["avatar_path"] ?? "",
      rating: json["rating"] ?? 0.0,
    );
  }
}
