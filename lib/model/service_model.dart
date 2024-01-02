// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  final String? id;
  final String? serviceName;
  final String? serviceId;
  final String? image;
  final String? location;
  final String? providerUid;
  final String? options;
  final String? description;
  final DateTime? createAt;

  ServiceModel({
    this.id,
    this.serviceName,
    this.serviceId,
    this.image,
    this.location,
    this.providerUid,
    this.options,
    this.description,
    this.createAt
  });

  factory ServiceModel.fromJson(QueryDocumentSnapshot json) => ServiceModel(
    id: json["id"],
    serviceName: json["category_name"],
    serviceId: json["category_id"],
    image: json["image"],
    location: json["location"],
    providerUid: json["provider_uid"],
    description: json["description"],
    options: json['options'],
    createAt: json['create_at'].toDate(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": serviceName,
    "category_id": serviceId,
    "image": image,
    "location": location,
    "provider_uid": providerUid,
    "description": description,
    "options":options,
    "create_at": createAt
  };
}
