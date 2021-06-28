// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.name,
    this.profileImage,
    this.dataTime,
    this.postimage,
    this.text,
    this.uid,
  });

  String name;

  String profileImage;
  String dataTime;
  String postimage;
  String text;
  String uid;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        name: json["name"],
        profileImage: json["profileImage"],
        dataTime: json["dataTime"],
        postimage: json["postimage"],
        text: json["text"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profileImage": profileImage,
        "dataTime": dataTime,
        "postimage": postimage,
        "text": text,
        "uid": uid,
      };
}
