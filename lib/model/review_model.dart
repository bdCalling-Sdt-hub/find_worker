
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? id;
  String? content;
  String? uid;
  String? userName;
  double? rating;
  String? serviceId;
  DateTime? createAt;

  ReviewModel({
    this.id,
    this.content,
    this.uid,
    this.rating,
    this.userName,
    this.createAt,
    this.serviceId,
  });

  factory ReviewModel.fromJson(Map<String,dynamic> json) => ReviewModel(
    id: json["id"],
    content: json["content"],
    uid: json["uid"],
    rating: json["rating"].toDouble(),
    createAt: json["create_at"].toDate(),
    userName: json['user_name'],
      serviceId: json['service_id']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "uid": uid,
    "rating": rating,
    "create_at": createAt,
    "user_name":userName,
    "service_id":serviceId
  };
}
