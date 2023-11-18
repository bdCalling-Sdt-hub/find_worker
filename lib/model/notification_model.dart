

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? id;
  String? content;
  DateTime? createAt;
  String? seen;
  String? senderId;
  String? status;
  String? historyId;

  NotificationModel({
    this.id,
    this.content,
    this.createAt,
    this.seen,
    this.senderId,
    this.status,
    this.historyId,
  });

  factory NotificationModel.fromJson(QueryDocumentSnapshot json) => NotificationModel(
    id: json["id"],
    content: json["content"],
    createAt: json["create_at"].toDate(),
    seen: json["seen"],
    senderId: json["sender_id"],
    status: json["status"],
    historyId: json["history_id"],
  );

}
