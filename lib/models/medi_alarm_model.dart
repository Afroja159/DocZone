

class MediAlarmModel {
  String? id, medicineName, medicinePower, startingDate,endingDate,morningTime,
      noonTime,nightTime,imageUrl,beforeOrAfterMeal,note;


  MediAlarmModel(
      {this.id,
      this.medicineName,
      this.medicinePower,
      this.startingDate,
      this.endingDate,
      this.morningTime,
      this.noonTime,
      this.nightTime,
      this.imageUrl,
      this.note,
      this.beforeOrAfterMeal});

  factory MediAlarmModel.fromMap(Map<String, dynamic> map) {
    return MediAlarmModel(
      id: map["id"],
      medicineName: map["medicineName"],
      medicinePower: map["medicinePower"],
      startingDate: map["startingDate"],
      imageUrl: map["imageUrl"],
      endingDate: map["endingDate"],
      morningTime: map["morningTime"],
      noonTime: map["noonTime"],
      nightTime: map["nightTime"],
      note: map["note"],
      beforeOrAfterMeal: map["beforeOrAfterMeal"],

    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id": id,
      "medicineName": medicineName,
      "medicinePower": medicinePower,
      "startingDate": startingDate,
      "endingDate": endingDate,
      "imageUrl": imageUrl,
      "morningTime": morningTime,
      "noonTime": noonTime,
      "nightTime": nightTime,
      "note": note,
      "beforeOrAfterMeal": beforeOrAfterMeal,

    };
  }
}
