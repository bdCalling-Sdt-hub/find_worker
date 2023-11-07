// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserByServiceModel {
  final String? id;
  final String? serviceName;
  final String? serviceId;
  final String? image;
  final String? location;
  final String? providerUid;
  final double? averageRating;
  final String? description;
  final String? providerName;

  UserByServiceModel({
    this.id,
    this.providerName,
    this.serviceName,
    this.serviceId,
    this.image,
    this.location,
    this.providerUid,
    this.averageRating,
    this.description,
  });

  factory UserByServiceModel.fromJson(Map<String, dynamic> json) => UserByServiceModel(
    id: json["id"],
    serviceName: json["category_name"],
    serviceId: json["category_id"],
    providerName:json["provider_name"],
    image: json["image"],
    location: json["location"],
    providerUid: json["provider_uid"],
    averageRating: json["average_rating"]?.toDouble(),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": serviceName,
    "category_id": serviceId,
    "image": image,
    "location": location,
    "provider_uid": providerUid,
    "average_rating": averageRating,
    "description": description,
  };
}
