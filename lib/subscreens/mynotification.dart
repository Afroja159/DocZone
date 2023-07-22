import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/auth/auth_service.dart';
import 'package:doczone/models/notification_model.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dbHelper/db_helper.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notificationModel = [];

bool checkedNotification=false;
  @override
  void initState() {
    fetchNotificationData();
    // fetchUserData();
    super.initState();
  }

  void fetchNotificationData()async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      showDialog(context: context,
          barrierDismissible: false,
          builder: (context)=>
              Center(child: CircularProgressIndicator(),)
      );
      List<NotificationModel> fetchNotification = await DbHelper.fetchNotificationData();
      setState(() {
        notificationModel = fetchNotification;

      });
      Navigator.pop(context);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: fontStyle(23, textClrELight, FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body:Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [

            Expanded(
              child:
              ListView.builder(
                itemCount: notificationModel.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  NotificationModel notifications = notificationModel[index];
                  DateTime creationTime = notifications.notificationCreationTime.toDate();
                  String formattedTime = DateFormat('hh:mm a').format(creationTime);
                  DateTime currentTime = DateTime.now();
                  // DateTime postTime = DateTime.parse(notifications.notificationCreationTime.toDate());

                  // Duration difference = postTime.difference(currentTime);
                  return  InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Notification'),
                            content: Text('Click ok to delete the notification'),
                            actions: [

                              TextButton(
                                onPressed: () async{
                                  final userId= AuthService.user!.uid;

                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(userId) // Replace `userId` with the actual user ID
                                      .collection('Notifications')
                                      .doc(notifications.notificationId)
                                      .update({'isRead': true});
                                  Navigator.pop(context);
                                  fetchNotificationData();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async{
                                  final userId= AuthService.user!.uid;
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(userId) // Replace `userId` with the actual user ID
                                        .collection('Notifications')
                                        .doc(notifications.notificationId)
                                        .delete();

                                    print('Document deleted successfully');
                                    Navigator.pop(context);
                                    fetchNotificationData();

                                  } catch (e) {
                                    print('Error deleting document: $e');
                                    Navigator.pop(context);

                                  }
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                          !notifications.isRead? Colors.red[50]:Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              notifications.notificationTitle??"",
                              style: fontStyle(12, textClrDark, FontWeight.bold),
                            ),
                            Text(
                              notifications.notificationBody??"",
                              style: fontStyle(14, Colors.orangeAccent, FontWeight.bold),
                            ),
                            Text(
                              "Notification Time : ${formattedTime}"
                                  " Date : "
                                  " ${notifications.notificationCreationTime.toDate().year} "
                                  "- ${notifications.notificationCreationTime.toDate().day}"
                                  " - ${notifications.notificationCreationTime.toDate().month}",
                              style: fontStyle(16, buttonClr, FontWeight.bold),
                            ),
                          ],),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}