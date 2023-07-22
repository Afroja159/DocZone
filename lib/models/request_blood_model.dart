

import 'package:cloud_firestore/cloud_firestore.dart';

class RequestBloodModel {
  String? id,requestById,donatedBloodDate,requestByName,acceptedById,acceptedByName,
      patientName,patientAge,bloodGroup,numberOfBags,contactNumber,
      bloodNeedDate,bloodNeedTime,hospitalName,hospitalLocation,details;
  Timestamp creationTime;

  bool isAccepted;
  bool isBloodDonated;


  RequestBloodModel(
      {this.id,
      this.patientName,
      this.requestByName,
      this.donatedBloodDate,
      this.acceptedById,
      this.acceptedByName,
      this.requestById,
      this.patientAge,
      this.bloodGroup,
      this.numberOfBags,
      this.contactNumber,
      this.bloodNeedDate,
      this.bloodNeedTime,
      this.hospitalName,
      this.hospitalLocation,
      this.details,
        required this.creationTime,

        this.isAccepted=false,
        this.isBloodDonated=false

      });

  factory RequestBloodModel.fromMap(Map<String, dynamic> map) {
    return RequestBloodModel(
      id: map["id"],
      requestById: map["requestById"],
      requestByName: map["requestByName"],
      donatedBloodDate: map["donatedBloodDate"],
      acceptedById: map["acceptedById"],
      acceptedByName: map["acceptedByName"],
      patientName: map["patientName"],
      patientAge: map["patientAge"],
      bloodGroup: map["bloodGroup"],
      numberOfBags: map["numberOfBags"],
      contactNumber: map["contactNumber"],
      bloodNeedDate: map["bloodNeedDate"],
      bloodNeedTime: map["bloodNeedTime"],
      hospitalName: map["hospitalName"],
      hospitalLocation: map["hospitalLocation"],
      details: map["details"],
      creationTime: map["userCreationTime"],
      isAccepted: map["isAccepted"],
      isBloodDonated: map["isBloodDonated"],

    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id": id,
      "requestById": requestById,
      "requestByName": requestByName,
      "donatedBloodDate": donatedBloodDate,
      "patientName": patientName,
      "acceptedById": acceptedById,
      "acceptedByName": acceptedByName,
      "patientAge": patientAge,
      "bloodGroup": bloodGroup,
      "numberOfBags": numberOfBags,
      "contactNumber": contactNumber,
      "bloodNeedDate": bloodNeedDate,
      "bloodNeedTime": bloodNeedTime,
      "hospitalName": hospitalName,
      "hospitalLocation": hospitalLocation,
      "userCreationTime": creationTime,
      "details": details,
      "isAccepted": isAccepted,
      "isBloodDonated": isBloodDonated,

    };
  }
}
