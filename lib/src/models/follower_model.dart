import 'dart:convert';

import 'package:debts/src/models/user_model.dart';

FollowerModel followerModelFromJson(String str) => FollowerModel.fromJson(json.decode(str));

String followerModelToJson(FollowerModel data) => json.encode(data.toJson());

class FollowerModel {
  int id;
  int followerId;
  int followedId;
  bool accepted;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel follower;
  UserModel followed;

  FollowerModel({
    this.id,
    this.followerId,
    this.followedId,
    this.accepted,
    this.createdAt,
    this.updatedAt,
    this.follower,
    this.followed,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
        id: json["id"],
        followerId: json["follower_id"],
        followedId: json["followed_id"],
        accepted: json["accepted"],
        follower: UserModel.fromJson(json["follower"]),
        followed: UserModel.fromJson(json["followed"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "follower_id": followerId,
        "followed_id": followedId,
        "accepted": accepted,
      };
}
