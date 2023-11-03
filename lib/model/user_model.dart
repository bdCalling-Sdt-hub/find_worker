
class UserModel{
  String? uid;
  String? userName;
  String? email;
  String? year;
  String? month;
  String? day;
  String? phone;
  String? address;
  String? imageSrc;

  UserModel({this.uid, this.userName, this.email,this.year,this.month,this.day, this.phone,this.address, this.imageSrc});

  // receive data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(

      uid: map['uid'],
      userName: map['username'],
      email: map['email'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
      phone: map['phoneNumber'],
      address: map['address'],
      imageSrc: map['imageSrc'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap()
  {
    return {

      'uid': uid,
      'username': userName,
      'email': email,
      'year': year,
      'month': month,
      'day': day,
      'phoneNumber': phone,
      'address': address,
      'imageSrc': imageSrc,
    };
  }
}