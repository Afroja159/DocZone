import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? notificationId;
  String? notificationTitle,notificationBody;
  bool isRead;
  Timestamp notificationCreationTime;

  NotificationModel(
      { this.notificationId,
        this.notificationTitle,
        this.notificationBody,
        required this.notificationCreationTime,
        this.isRead=false

      });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'notificationId' : notificationId,
      'notificationTitle' : notificationTitle,
      'notificationBody' : notificationBody,
      'notificationCreationTime' : notificationCreationTime,
      'isRead' : isRead,

    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) => NotificationModel(
    notificationId: map['notificationId'],
    notificationTitle: map['notificationTitle'],
    notificationBody: map['notificationBody'],
    notificationCreationTime: map['notificationCreationTime'],
    isRead: map['isRead'],
  );
}