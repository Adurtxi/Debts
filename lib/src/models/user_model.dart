import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String name;
  String surname;
  String email;
  String image;
  int follStatus;

  UserModel({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.image,
    this.follStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        image: json["image"],
        follStatus: json["follStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "image": image,
      };
}
