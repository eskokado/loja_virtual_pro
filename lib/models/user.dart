class User {
  User({required this.email, required this.password, this.name});

  String? name;
  String email;
  String password;

  String? confirmPassword;
}
