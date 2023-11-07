
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  final String? name;
  final String? id;
  final String? image;

  CategoryModel({
    this.name,
    this.id,
    this.image,
  });

  factory CategoryModel.fromJson(QueryDocumentSnapshot json) => CategoryModel(
    name: json["name"],
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "image": image,
  };
}
