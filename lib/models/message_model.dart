import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  int? msgId;
  String userUid;
  String? userName;
  String? userImage;
  String email;
  String msg;
  Timestamp timestamp;
  String? image;

  MessageModel(
      {
        this.msgId,
        required this.userUid,
        this.userName,
        this.userImage,
        required this.email,
        required this.msg,
        required this.timestamp,
        this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'msgId' : msgId,
      'userUid' : userUid,
      'userName' : userName,
      'email' : email,
      'userImage' : userImage,
      'msg' : msg,
      'timestamp' : timestamp,
      'image' : image,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
    msgId: map['msgId'],
    userUid: map['userUid'],
    userName: map['userName'],
    email: map['email'],
    userImage: map['userImage'],
    msg: map['msg'],
    timestamp: map['timestamp'],
    image: map['image'],
  );
}
