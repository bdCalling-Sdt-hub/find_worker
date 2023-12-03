
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? uid;
  String? userName;
  String? email;
  DateTime? dob;
  String? phone;
  String? address;
  String? imageSrc;
  String? gender;
  String? status;
  String? authType;
  DateTime? timestamp;
  String? role;
  String? fcmToken;
  double? averageRating;
  String? phoneCode;
  UserModel({this.uid,this.phoneCode,this.averageRating, this.fcmToken,this.role, this.userName, this.email,this.dob, this.phone,this.address, this.imageSrc,this.gender,this.status,this.authType,this.timestamp});

  // receive data from server
  factory UserModel.fromMap(DocumentSnapshot map)
  {
    return UserModel(
      uid: map['uid'],
      phoneCode: map['phone_code'],
      averageRating: map['average_rating'].toDouble(),
      userName: map['username'],
      fcmToken: map['fcmToken'],
      email: map['email'],
      dob: map['dob'].toDate(),
      phone: map['phone'],
      address: map['address'],
      imageSrc: map['imageSrc'],
      gender: map['gender'],
      status: map['status'],
      timestamp: map['timestamp'].toDate(),
      authType: map['authType'],
      role: map['role']
    );
  }

  // sending data to server
  Map<String, dynamic> toMap()
  {
    return {
      'uid': uid,
      'username': userName,
      'email': email,
      'dob': dob,
      'phone': phone,
      'address': address,
      'imageSrc': imageSrc,
      'gender':gender,
      'status':status,
      'timestamp':timestamp,
      'authType':authType,
      'role':role,
      'fcmToken':fcmToken,
      'average_rating':averageRating,
      'phone_code':phoneCode,
    };
  }
}