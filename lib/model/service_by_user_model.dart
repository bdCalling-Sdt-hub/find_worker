// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserByServiceModel {
  final String? id;
  final String? serviceName;
  final String? serviceCatId;
  final String? image;
  final String? location;
  final String? providerUid;
  final double? averageRating;
  final String? description;
  final String? providerName;
  final String? phoneCode;
  final String? phone;
  final String? options;
  final DateTime? createAt;

  UserByServiceModel({
    this.phone,
    this.phoneCode,
    this.id,
    this.providerName,
    this.serviceName,
    this.serviceCatId,
    this.image,
    this.location,
    this.providerUid,
    this.averageRating,
    this.description,
    this.options,
    this.createAt
  });

  factory UserByServiceModel.fromJson(Map<String, dynamic> json) => UserByServiceModel(
    id: json["id"],
    serviceName: json["category_name"],
    serviceCatId: json["category_id"],
    providerName:json["provider_name"],
    image: json["image"],
    location: json["location"],
    providerUid: json["provider_uid"],
    averageRating: json["average_rating"]?.toDouble(),
    description: json["description"],
    phone: json['phone'],
    phoneCode: json['phone_code'],
    options: json['options'],
    createAt: json['create_at'].toDate(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": serviceName,
    "category_id": serviceCatId,
    "image": image,
    "location": location,
    "provider_uid": providerUid,
    "average_rating": averageRating,
    "description": description,
    "options":options,
    "create_at":createAt
  };
}
