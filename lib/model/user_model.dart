
class UserModel{
  String? uid;
  String? userName;
  String? email;
  String? dob;
  String? phone;
  String? address;
  String? imageSrc;
  String? gender;
  String? status;
  String? authType;
  String? password;
  DateTime? timestamp;
  String? role;
  String? fcmToken;
  UserModel({this.uid,this.fcmToken,this.role, this.userName, this.email,this.dob, this.phone,this.address, this.imageSrc,this.gender,this.status,this.authType,this.password,this.timestamp});

  // receive data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      userName: map['username'],
      fcmToken: map['fcmToken'],
      email: map['email'],
      dob: map['dob'],
      phone: map['phone'],
      address: map['address'],
      imageSrc: map['imageSrc'],
      gender: map['gender'],
      status: map['status'],
      password: map['password'],
      timestamp: map['timestamp'],
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
      'password':password,
      'timestamp':timestamp,
      'authType':authType,
      'role':role,
      'fcmToken':fcmToken,
    };
  }
}