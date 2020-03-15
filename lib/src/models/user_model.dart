import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String name;
  String surname;
  String email;
  String password;
  bool darkMode;
  int iat;
  int exp;

  UserModel({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.darkMode,
    this.iat,
    this.exp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
        darkMode: json["dark_mode"],
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "dark_mode": darkMode,
        "iat": iat,
        "exp": exp,
      };
}
