// To parse this JSON data, do
//
//     final hireModel = hireModelFromJson(jsonString);

import 'dart:convert';

List<HireModel> hireModelFromJson(String str) => List<HireModel>.from(json.decode(str).map((x) => HireModel.fromJson(x)));

String hireModelToJson(List<HireModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HireModel {
  String? id;
  String? uid;
  String? name;
  String? status;
  double? averageRating;
  String? serviceName;
  String? serviceNameArabic;
  String? serviceId;
  String? image;
  String? contact;
  String? address;
  DateTime? createAt;
  String? userFcmToken;
  String? userRole;

  HireModel({
    this.id,
    this.uid,
    this.name,
    this.status,
    this.averageRating,
    this.serviceName,
    this.serviceNameArabic,
    this.serviceId,
    this.image,
    this.contact,
    this.address,
    this.createAt,
    this.userFcmToken,
    this.userRole,
  });

  factory HireModel.fromJson(Map<String, dynamic> json) => HireModel(
    id: json["id"],
    uid: json["uid"],
    name: json["name"],
    status: json["status"],
    averageRating: json["average_rating"],
    serviceName: json["service_name"],
      serviceNameArabic: json["category_arabic"],
    serviceId: json["service_id"],
    image: json["image"],
    contact: json["contact"],
    address: json["address"],
    createAt: json["create_at"].toDate(),
    userFcmToken: json['fcmToken'],
      userRole: json['userType']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "name": name,
    "status": status,
    "average_rating": averageRating,
    "service_name": serviceName,
    "service_id": serviceId,
    "image": image,
    "contact": contact,
    "address": address,
    "create_at": createAt,
    "fcmToken":userFcmToken,
    "userType":userRole,
    "category_arabic":serviceNameArabic
  };
}
