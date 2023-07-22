import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/subscreens/accepted_request.dart';
import 'package:doczone/subscreens/blood_bank.dart';
import 'package:doczone/subscreens/request_for_blood.dart';
import 'package:doczone/subscreens/submitted_blood_request.dart';
import 'package:doczone/utils/helper_functions.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:doczone/widgets/home_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../auth/auth_service.dart';
import '../dbHelper/db_helper.dart';
import '../main.dart';
import '../models/notification_model.dart';
import 'chat_room_page.dart';
import 'donated_blood.dart';

class BloodCenter extends StatefulWidget {
  const BloodCenter({super.key});

  @override
  State<BloodCenter> createState() => _BloodCenterState();
}

class _BloodCenterState extends State<BloodCenter> {

  bool isOn = false;



  bool isUploading = false, isSaving = false;


  String uid = '';
  String firstName = '';
  String mobile = '';
  String lastName = '';
  String address = '';
  String dob = '';
  String gender = '';
  String image = '';
  String bloodGroup = '';
  Timestamp? bloodDonationDate;
  Timestamp? newUserLastDonateDate;

  String deviceToken = '';
  String userCreationTime = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
    if(mounted){
      // showDonarAvailabilityNotification();
    }
  }

  bool isNotificationCreated = false; // Track if the notification has been created
  String lastNotificationDate = ''; // Store the date of the last notification

  Future<void> fetchUserData() async {
    try {
      String uid = AuthService.user!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          this.uid = uid;
          bloodDonationDate = data['bloodDonationDate'] as Timestamp?;
          firstName = data['firstName'];
        });
      }

      if (bloodDonationDate != null) {

        DateTime currentDate = DateTime.now();
        DateTime donationDate = bloodDonationDate!.toDate(); // Convert Timestamp to DateTime

        Duration difference = currentDate.difference(donationDate);
        print(difference.inDays);
        if (difference.inDays >= 90) {
          flutterLocalNotificationsPlugin.show(
              0,
              "You can Now Donate Blood",
              "Your blood donation date is 90 days or older. Now You Can Donate Blood",
              NotificationDetails(
                  android: AndroidNotificationDetails(channel.id, channel.name,
                      importance: Importance.high,
                      color: Colors.blue,
                      playSound: true,
                      icon: '@mipmap/ic_launcher')));
          print(AuthService.user!.uid);
          print(uid);

          if (AuthService.user!.uid == uid) {
            _saveNotification();
          }

          print('The blood donation is 90 days or older.');
          setState(() {
            isOn = true;
          });
        }

        else {
          flutterLocalNotificationsPlugin.show(
              0,
              "You can't Now Donate Blood",
              "Your blood donation date is Less than 90 days. Now You Can't Donate Blood",
              NotificationDetails(
                  android: AndroidNotificationDetails(channel.id, channel.name,
                      importance: Importance.high,
                      color: Colors.blue,
                      playSound: true,
                      icon: '@mipmap/ic_launcher')));
          print('The blood donation is less than 90 days old.');
          setState(() {
            isOn = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  _saveNotification() async {
    final notification = NotificationModel(

      notificationTitle: 'Hey $firstName, Happy News for you',
      notificationBody:
      'You can Now Donate Blood, Your Last donate date is more than 90 days so donate blood now! Save Life!!',
      notificationCreationTime: Timestamp.now(),
    );
    final bool status = await DbHelper.addNotification(notification);
    if (status) {
      print('Notification created successfully');
    } else {
      print('Error creating notification');
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: const HomeButton(),
        floatingActionButton: Card(

          child: IconButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoomPage()));
          },
            icon:Icon(Icons.textsms,size: 30,color: Colors.redAccent,),),
        ),
        appBar: AppBar(

          title: Text(
            'Blood Center',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     RichText(
                //       text: TextSpan(
                //         children: <TextSpan>[
                //           isOn == true
                //               ? TextSpan(
                //                   text: 'Available ',
                //                   style: fontStyle(
                //                       17, Colors.green, FontWeight.bold))
                //               : TextSpan(
                //                   text: 'Not Available ',
                //                   style: fontStyle(
                //                       16, Colors.grey, FontWeight.bold)),
                //           TextSpan(
                //               text: 'for Blood Donation',
                //               style: fontStyle(16, textClrDark, FontWeight.bold)),
                //         ],
                //       ),
                //     ),
                //     Switch(
                //         value: isOn,
                //         onChanged: (val) {
                //           if(isOn){
                //             print("ami true");
                //           }
                //           else{
                //             print("ami false");
                //           }
                //           setState(() {
                //             isOn = val;
                //           });
                //         }),
                //   ],
                // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            isOn ?
            Container(
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(onPressed: (){

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Not Eligible for Blood Donation'),
                      content: Text('Your last blood donation date does not meet our donation rules.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            updateBloodDonationDate();
                            fetchUserData();
                            print(bloodDonationDate.toString());
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );




              }, child: Text("Available",style: TextStyle(color: Colors.green,
                  fontSize: 18,fontWeight: FontWeight.w700),)),
            ):
            Container(

              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(

                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Not Eligible for Blood Donation'),
                          content: Text('Your last blood donation date does not meet our donation rules.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

              }, child: Text("Not Available",style: TextStyle(color: Colors.red,
                  fontSize: 18,fontWeight: FontWeight.w700),)),
            ),
            Text("For Blood Donation",style: TextStyle(color: Colors.black,
                fontSize: 18,fontWeight: FontWeight.w700)),
              bloodDonationDate != null ?
                  SizedBox():
              IconButton(onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Please Provide Your  Blood Donate Information'),
                      content:Text('Your Last donate date is more than 90 days ?'),

                      actions: [
                        TextButton(
                          onPressed: () async{
                            String uid = AuthService.user!.uid;
                            try {
                              Timestamp currentTimestamp = Timestamp.now();
                              DateTime currentDate = currentTimestamp.toDate();
                              DateTime targetDate = currentDate.subtract(Duration(days: 100));
                              Timestamp olderTimestamp = Timestamp.fromDate(targetDate);

                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(uid)
                                  .update({'bloodDonationDate': olderTimestamp});
                              fetchUserData();
                              Navigator.of(context).pop();
                              showMsg(context, "Blood donation date updated successfully");

                              print('Blood donation date updated successfully');
                            } catch (e) {
                              showMsg(context, "Error updating blood donation date");
                              Navigator.of(context).pop();
                              print('Error updating blood donation date: $e');
                            }
                          },
                          child: Text('YES'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('NO'),
                        ),
                      ],
                    );
                  },
                );
              },
                  icon: Icon(Icons.event_available,color: Colors.green,))
          ],),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BloodBank(),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/bloodBankBg.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Blood Bank',
                          style: fontStyle(26, textClrELight, FontWeight.bold),
                        ),
                        Text(
                          'GIFT OF LIFE',
                          style: fontStyle(16, textClrELight),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RequestForBlood(),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                            image:
                                AssetImage('assets/images/requestforBlood.png'),
                            fit: BoxFit.cover),
                        color: const Color(0xffBACDDB)),
                    child: Column(
                      children: [
                        Text(
                          'Request for Blood',
                          textAlign: TextAlign.center,
                          style: fontStyle(26, textClrDark, FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Tap here for Submit a New Request',
                          textAlign: TextAlign.center,
                          style: fontStyle(12, textClrDLight, FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                ListTile(
                  onTap: () {
                    // requestInfo();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SubmittedBloodRequest()));

                  },
                  contentPadding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  tileColor: textClrELight,
                  leading:
                  Icon(Icons.pending_actions,color: Colors.orange,size: 35,),

                  title: Text(
                    'Submitted Request',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                  trailing: Text(
                    'View',
                    style: fontStyle(15, buttonClr, FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                ListTile(
                  onTap: () {
                    // acceptInfo();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptedBlood()));
                  },
                  contentPadding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  tileColor: textClrELight,
                  leading:
                  Icon(Icons.gpp_good_outlined,color: Colors.green,size: 35,),
                  // Text(
                  //   'X',
                  //   style: fontStyle(20, buttonClr, FontWeight.w700),
                  // ),
                  title: Text(
                    'Accepted Request',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                  trailing: Text(
                    'View',
                    style: fontStyle(15, buttonClr, FontWeight.w600),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                ListTile(
                  onTap: () {
                    // acceptInfo();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DonatedBlood()));
                  },
                  contentPadding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  tileColor: textClrELight,
                  leading:
                  Icon(Icons.bloodtype,color: Colors.red,size: 35,),
                  // Text(
                  //   'X',
                  //   style: fontStyle(20, buttonClr, FontWeight.w700),
                  // ),
                  title: Text(
                    'Donated Blood',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                  trailing: Text(
                    'View',
                    style: fontStyle(15, buttonClr, FontWeight.w600),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateBloodDonationDate() async {
    String uid = AuthService.user!.uid;
    try {
      Timestamp timestamp = Timestamp.now();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .update({'bloodDonationDate': timestamp});
      showMsg(context, "Blood donation date updated successfully");

      print('Blood donation date updated successfully');
    } catch (e) {
      showMsg(context, "Error updating blood donation date");

      print('Error updating blood donation date: $e');
    }
  }



}
