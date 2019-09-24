import 'dart:convert';

class User {
  final String email;

  User({this.email});

  static User userFromJson(String string) => User.fromMap(json.decode(string));
  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) {
    return User(email: json["email"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
    };
  }

  @override
  String toString() {
    return 'User { email: $email }';
  }
}
