import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? firstName,lastname,fullName,address,dob,gender,bloodGroup,email;
  String? mobile;
  String? image;
  Timestamp userCreationTime;
  Timestamp? bloodDonationDate;
  String? deviceToken;

  UserModel(
      {required this.uid,
        this.firstName,
        this.lastname,
        this.fullName,
        this.email,
        this.address,
        this.dob,
        this.gender,
        this.bloodGroup,
        this.mobile,
        this.image,
        this.bloodDonationDate,
        required this.userCreationTime,
        this.deviceToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'uid' : uid,
      'firstName' : firstName,
      'fullName' : fullName,
      'email' : email,
      'mobile' : mobile,
      'lastname' : lastname,
      'address' : address,
      'dob' : dob,
      'gender' : gender,
      'bloodGroup' : bloodGroup,
      'image' : image,
      'bloodDonationDate' : bloodDonationDate,
      'deviceToken' : deviceToken,
      'userCreationTime' : userCreationTime,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['uid'],
    firstName: map['firstName'],
    fullName: map['fullName'],
    mobile: map['mobile'],
    email: map['email'],
    lastname: map['lastname'],
    address: map['address'],
    dob: map['dob'],
    gender: map['gender'],
    bloodGroup: map['bloodGroup'],
    image: map['image'],
    bloodDonationDate: map['bloodDonationDate'],
    deviceToken: map['deviceToken'],
    userCreationTime: map['userCreationTime'],
  );
}