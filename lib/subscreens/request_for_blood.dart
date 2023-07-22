import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/models/request_blood_model.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../auth/auth_service.dart';
import '../dbHelper/db_helper.dart';
import '../main.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';
import '../utils/helper_functions.dart';

class RequestForBlood extends StatefulWidget {
  const RequestForBlood({super.key});

  @override
  State<RequestForBlood> createState() => _RequestForBloodState();
}

class _RequestForBloodState extends State<RequestForBlood> {
  TextEditingController patientController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController bagsController = TextEditingController();
  TextEditingController hospitalLocationController = TextEditingController();
  TextEditingController hospitalNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  List<String> bloodList = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  String? selectedBlood;
  String? requestBloodDate;

  GlobalKey<FormState> bloodKey = GlobalKey();

@override
  void initState() {
  fetchFirebaseNotification();
        super.initState();
  }


  void fetchFirebaseNotification(){

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });

  }


  void showNotification() {


    flutterLocalNotificationsPlugin.show(
        0,
        "New Blood Request Submitted",
        "Please check blood center to check new blood request",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
    _saveNotification();
  }






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Request for Blood',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Form(
              key: bloodKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Patient Name',
                              style:
                                  fontStyle(15, textClrDark, FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '*required';
                                }
                                return null;
                              },
                              controller: patientController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                hintText: 'Patient Name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: buttonClr),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: buttonClr),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.redAccent),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.redAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Patient Age',
                              style:
                                  fontStyle(15, textClrDark, FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '*required';
                                }
                                if (value.length > 3) {
                                  return 'Invalid';
                                }
                                return null;
                              },
                              controller: ageController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                hintText: 'Age',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: buttonClr),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: buttonClr),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.redAccent),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.redAccent),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Blood Group',
                                style:
                                    fontStyle(15, textClrDark, FontWeight.w600),
                              ),
                              const SizedBox(height: 5),
                              DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return '*required';
                                  }
                                  return null;
                                },
                                value: selectedBlood,
                                items: bloodList
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        ))
                                    .toList(),
                                decoration: InputDecoration(
                                  hintText: 'Blood Group',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  prefixIcon: const Icon(
                                    Icons.bloodtype,
                                    color: buttonClr,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: buttonClr),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: buttonClr),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                ),
                                onChanged: (bloodValue) {
                                  setState(() {
                                    selectedBlood = bloodValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Number of Bags',
                                style:
                                    fontStyle(15, textClrDark, FontWeight.w600),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '*required';
                                  }
                                  if (value.length > 1) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                                controller: bagsController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  hintText: 'Bags',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: buttonClr),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: buttonClr),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Contact Number',
                    style: fontStyle(15, textClrDark, FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '*required';
                      }
                      if (value.length < 11 || value.length > 11) {
                        return 'Invalid Phone Number';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      prefixIcon: const Icon(Icons.phone),
                      prefixIconColor: buttonClr,
                      hintText: 'Contact Number',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: buttonClr),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: buttonClr),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          'When will Blood be needed ?',
                          style: fontStyle(16, textClrDark, FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '*required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.none,
                                controller: dateController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  hintText: 'Date',
                                  labelText: 'Date',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: buttonClr),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: buttonClr),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2024));
                                  if (pickedDate != null) {
                                    setState(() {
                                      // dateController.text =pickedDate.toString();

                                      dateController.text =
                                          DateFormat("dd - MM - yyyy")
                                              .format(pickedDate);

                                      requestBloodDate =pickedDate.toString();
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '*required';
                                  }
                                  return null;
                                },
                                controller: timeController,
                                keyboardType: TextInputType.none,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  hintText: 'Time',
                                  labelText: 'Time',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: buttonClr),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: buttonClr),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                ),
                                onTap: () async {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (selectedTime != null) {
                                    timeController.text =
                                        // ignore: use_build_context_synchronously
                                        selectedTime.format(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hospital Name',
                        style: fontStyle(15, textClrDark, FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*required';
                          }
                          return null;
                        },
                        controller: hospitalNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          hintText: 'Hospital Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: buttonClr),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: buttonClr),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hospital Location',
                          style: fontStyle(15, textClrDark, FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '*required';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.streetAddress,
                          controller: hospitalLocationController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            prefixIcon: const Icon(Icons.location_on),
                            prefixIconColor: buttonClr,
                            hintText: 'Hospital Loction',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: buttonClr),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: buttonClr),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: detailsController,
                      maxLength: 100,
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        hintText: 'Details :',
                        labelText: 'Details :',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: buttonClr),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: buttonClr),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: double.infinity,
                    color: buttonClr,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33),
                    ),
                    onPressed: () {


                      if (bloodKey.currentState!.validate()) {
                        _saveRequestBlood();
                        showNotification();
                      }
                    },
                    child: Text(
                      'SUBMIT Request',
                      style: fontStyle(16, textClrELight, FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveRequestBlood() async{

    // showDialog(context: context,
    //     barrierDismissible: false,
    //     builder: (context)=>
    //         Center(child: CircularProgressIndicator(),)
    // );

    final requestBloodModel = RequestBloodModel(
      requestById: AuthService.user!.uid,
      requestByName: AuthService.user!.displayName,
      patientName: patientController.text.trim(),
      patientAge: ageController.text.trim(),
      bloodGroup: selectedBlood.toString(),
      numberOfBags: bagsController.text.trim(),
      contactNumber: phoneController.text.trim(),
      bloodNeedDate: requestBloodDate,
      bloodNeedTime: timeController.text.trim(),
      hospitalLocation: hospitalLocationController.text.trim(),
      hospitalName: hospitalNameController.text.trim(),
      details: detailsController.text.trim(),
      isAccepted: false,
      isBloodDonated: false,
      creationTime: Timestamp.fromDate(DateTime.now()),

    );

    bool status = await DbHelper.addBloodRequest(requestBloodModel);
    if(status){

      showMsg(context, 'Succesfully Added Blood Request');
      // Navigator.of(context).popUntil((route) => route.isFirst);
           Navigator.pop(context);

    }
    else{
      showMsg(context, 'Error in Adding New Blood Request');
      // Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pop(context);
    }

  }

   _saveNotification() async{

    final notification = NotificationModel(
      notificationTitle: 'New Blood Request Submitted by ${AuthService.user!.displayName}',
      notificationBody: 'Blood ${selectedBlood.toString()} Needed For Age ${ageController.text.trim()} Patient. Total Bag${bagsController.text.trim()}.',
      notificationCreationTime: Timestamp.now(),
    );
    final  bool status =await DbHelper.addNotification(notification,createCollectionForAllUsers: true);
    if(status){
      print('Notification created successfully');

    }
    else{
      print('Error creating notification');

    }
  }
}
