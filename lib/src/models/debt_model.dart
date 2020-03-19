import 'dart:convert';

import 'package:epbasic_debts/src/models/user_model.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

DebtModel debtModelFromJson(String str) => DebtModel.fromJson(json.decode(str));

String debtModelToJson(DebtModel data) => json.encode(data.toJson());

class DebtModel {
  int id;
  int userId;
  int defaulterId;
  double quantity;
  String title;
  String description;
  bool paid;
  UserModel user;
  UserModel defaulter;

  DebtModel({
    this.id,
    this.userId,
    this.defaulterId = 1,
    this.quantity = 0.0,
    this.title = '',
    this.description = '',
    this.paid = true,
    this.user,
    this.defaulter,
  });

  factory DebtModel.fromJson(Map<String, dynamic> json) => DebtModel(
        id: json["id"],
        userId: json["user_id"],
        defaulterId: json["defaulter_id"],
        quantity: json["quantity"].toDouble(),
        title: json["title"],
        description: json["description"],
        paid: json["paid"],
        user: UserModel.fromJson(json["user"]),
        defaulter: UserModel.fromJson(json["defaulter"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "defaulter_id": defaulterId,
        "quantity": quantity,
        "title": title,
        "description": description,
        "paid": paid,
      };
}
