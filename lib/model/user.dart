class User {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  User({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
  })  : name = name ?? "",
        email = email ?? "",
        password = password ?? "",
        confirmPassword = confirmPassword ?? "";

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      confirmPassword: json["confirmPassword"] ?? "",
    );
  }
}
