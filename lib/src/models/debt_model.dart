import 'dart:convert';

DebtModel debtModelFromJson(String str) => DebtModel.fromJson(json.decode(str));

String debtModelToJson(DebtModel data) => json.encode(data.toJson());

class DebtModel {
  int id;
  int userId;
  int defaulterId;
  String title;
  String description;
  bool paid;

  DebtModel({
    this.id,
    this.userId,
    this.defaulterId,
    this.title,
    this.description,
    this.paid,
  });

  factory DebtModel.fromJson(Map<String, dynamic> json) => DebtModel(
        id: json["id"],
        userId: json["user_id"],
        defaulterId: json["defaulter_id"],
        title: json["title"],
        description: json["description"],
        paid: json["paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "defaulter_id": defaulterId,
        "title": title,
        "description": description,
        "paid": paid,
      };
}
