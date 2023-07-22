import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/auth/auth_service.dart';
import 'package:doczone/dbHelper/db_helper.dart';
import 'package:doczone/subscreens/medi_alarm.dart';
import 'package:doczone/utils/helper_functions.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import '../models/medi_alarm_model.dart';

class MediTime extends StatefulWidget {
  const MediTime({super.key});

  @override
  State<MediTime> createState() => _MediTimeState();
}

class _MediTimeState extends State<MediTime> {

  List<MediAlarmModel> mediAlarmMoedl = [];


  @override
  void initState() {
   fetchMedicineAlarmData();
    super.initState();
  }


  void fetchMedicineAlarmData()async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      showDialog(context: context,
          barrierDismissible: false,
          builder: (context)=>
              Center(child: CircularProgressIndicator(),)
      );
      List<MediAlarmModel> fetchedMediAlarms = await DbHelper.fetchMedicineAlarms();
      setState(() {
        mediAlarmMoedl = fetchedMediAlarms;
      });
      Navigator.pop(context);
    });

  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: buttonClr,
            onPressed: () {

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MediAlarm()));
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text(
              'Medi Time',
              style: fontStyle(23, textClrELight, FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              children: [

                // TextButton(onPressed: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                // },child: Text("go to alarm page"),),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: mediAlarmMoedl.length,
                  itemBuilder: (context, index) {
                    MediAlarmModel mediAlarm = mediAlarmMoedl[index];

                    return InkWell(
                      onLongPress: () {
                        mediTimeAction(mediAlarm.id!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: ExpansionTile(
                          // leading: Image.network(mediAlarm.imageUrl??""),
                          leading:  mediAlarm.imageUrl == null
                              ?
                           Image.asset(
                            'assets/images/profile.png',
                            // height: 100,
                            // width: 100,
                            fit: BoxFit.cover,
                          )
                              : FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            image: mediAlarm.imageUrl!,
                            fadeInDuration: const Duration(seconds: 2),
                            fadeInCurve: Curves.bounceInOut,
                            // height: 100,
                            // width: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "${mediAlarm.medicineName??""} ${mediAlarm.medicinePower}",
                            style: fontStyle(16, textClrDark, FontWeight.w600),
                          ),
                          subtitle: Text(
                            mediAlarm.beforeOrAfterMeal??"",
                            style: fontStyle(14, textClrDLight),
                          ),
                          children: [
                            ListTile(
                              leading: Text(
                                'Date : ',
                                style:
                                    fontStyle(15, textClrDark, FontWeight.w700),
                              ),
                              title: Text(
                                '${mediAlarm.startingDate}   To   ${mediAlarm.endingDate}',
                                style:
                                    fontStyle(16, textClrDark, FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                'Time : ',
                                style:
                                    fontStyle(15, textClrDark, FontWeight.w700),
                              ),
                              title: Text(
                                '${mediAlarm.morningTime!.isNotEmpty ? mediAlarm.morningTime: "No Medicine"}'
                                    '- '
                                    '${mediAlarm.noonTime!.isNotEmpty ? mediAlarm.noonTime: "No Medicine"}'
                                    ' - '
                                    '${mediAlarm.nightTime!.isNotEmpty ? mediAlarm.nightTime: "No Medicine"}',
                                style:
                                    fontStyle(16, textClrDark, FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                'Note : ',
                                style:
                                    fontStyle(15, textClrDark, FontWeight.w700),
                              ),
                              title: Text(
                              "${mediAlarm.note.toString().isEmpty? "No note provided" : mediAlarm.note} ",
                                style:
                                    fontStyle(16, textClrDark, FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }

  mediTimeAction(String id) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              height: 3,
              width: 50,
              decoration: BoxDecoration(
                color: textClrLight,
                borderRadius: BorderRadius.circular(33),
              ),
            ),
            ListTile(
              onTap: () async{

                  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
                  try {
                    await usersCollection.doc(AuthService.user!.uid).collection("MedicineAlarm").doc(id).delete();


                    showMsg(context, 'Alarm deleted successfully.');
                    print('Document deleted successfully.');
                  } catch (error) {
                    showMsg(context, 'Error deleting Alarm.');

                    print('Error deleting document: $error');
                  }
                  fetchMedicineAlarmData();
                  Navigator.pop(context);

              },
              leading: const Icon(Icons.delete),
              title: Text(
                'Delete',
                style: fontStyle(15, textClrDark, FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
