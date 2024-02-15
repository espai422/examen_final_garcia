import 'dart:convert';

/// ProfileUser model, this model is used to keep the user's data
/// and to convert it to JSON and vice versa
/// it's created with the help of https://app.quicktype.io/
/// It's and abstraction of the user's data to be able to create different
/// types of login methods and reuse code bwetween them, theese are [FireAuth],
/// [SqliteAuth] and [RtdbAuth]
class ProfileUser {
  String username;
  String email;
  String password;

  ProfileUser({
    required this.username,
    required this.email,
    required this.password,
  });

  factory ProfileUser.fromJson(String str) =>
      ProfileUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileUser.fromMap(Map<String, dynamic> json) => ProfileUser(
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
