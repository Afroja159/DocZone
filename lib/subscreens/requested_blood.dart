import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/auth/auth_service.dart';
import 'package:doczone/utils/helper_functions.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dbHelper/db_helper.dart';
import '../models/request_blood_model.dart';

class RequestedBlood extends StatefulWidget {
  const RequestedBlood({super.key});

  @override
  State<RequestedBlood> createState() => _RequestedBloodState();
}

class _RequestedBloodState extends State<RequestedBlood> {



  String uid = '';
  String firstName = '';
  String mobile = '';
  String lastName = '';
  String fullName = '';
  String address = '';
  String dob = '';
  String gender = '';
  String bloodGroup = '';
  String image = '';
  String deviceToken = '';
  String userCreationTime = '';
  List<RequestBloodModel> requestBloodModel = [];


  @override
  void initState() {
    fetchRequestBloodData();
    super.initState();
  }

  void fetchRequestBloodData()async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      showDialog(context: context,
          barrierDismissible: false,
          builder: (context)=>
              Center(child: CircularProgressIndicator(),)
      );
      List<RequestBloodModel> fetchRequestBlood = await DbHelper.fetchRequestBloodData();
      setState(() {
        requestBloodModel = fetchRequestBlood;
      });
      Navigator.pop(context);
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'You can accept only ONE Blood Request',
                    style: fontStyle(15, textClrDLight, FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 2,
                    color: buttonClr,
                  ),
                ],
              ),
            ),
            Expanded(
              child:
              ListView.builder(
                itemCount: requestBloodModel.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  RequestBloodModel requestBlood = requestBloodModel[index];
                  DateTime currentTime = DateTime.now();
                  DateTime postTime = DateTime.parse(requestBlood.bloodNeedDate!);

                  Duration difference = postTime.difference(currentTime);
                  return InkWell(
                    onTap: () {
                      print(difference.inHours.toString());
                      print(requestBlood.bloodNeedDate.toString());
                      requestInfo(requestBlood);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: ListTile(
                        tileColor: Colors.yellow[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                            requestBlood.bloodGroup??"",
                            style:
                                fontStyle(16, textClrELight, FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          requestBlood.patientName??"",
                          style: fontStyle(16, textClrDark, FontWeight.bold),
                        ),
                        subtitle:
                            difference.inHours<=24?
                        Text(
                          'Emergency',
                          style: fontStyle(14, Colors.red, FontWeight.bold),
                        ):
                        Text(
                        'Partially Emergency',
                        style: fontStyle(14, Colors.orangeAccent, FontWeight.bold),
                      ),
                        trailing: Text(
                          'View Details',
                          style: fontStyle(16, buttonClr, FontWeight.bold),
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
  requestInfo(RequestBloodModel requestBlood) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  'Blood Request',
                  textAlign: TextAlign.center,
                  style: fontStyle(20, buttonClr, FontWeight.bold),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        requestBlood.bloodGroup??"",
                        style: fontStyle(40, Colors.red, FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 3,
                      height: 60,
                      color: buttonClr,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Contact',
                            textAlign: TextAlign.center,
                            style: fontStyle(16, Colors.blue, FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          MaterialButton(
                            color: buttonClr,
                            shape: const CircleBorder(),
                            onPressed: () async{
                              final Uri url = Uri(
                                  scheme: 'tel',
                                  path:
                                  '${requestBlood.contactNumber}');

                              if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.phone,
                                size: 20,
                                color: textClrELight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                Text(
                  'Patient Name  :   ${requestBlood.patientName??""}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Patient Age  :   ${requestBlood.patientAge??""}',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Text(
                  'Blood Group  :   ${requestBlood.bloodGroup??""}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Number of Bags  :   ${requestBlood.numberOfBags??""}',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Text(
                  'Contact Number  :   ${requestBlood.contactNumber??""}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Date  :   ${
                        DateFormat("dd - MM - yyyy")
                            .format(DateTime.parse(requestBlood.bloodNeedDate!))
                    }',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Text(
                  'Time  :   ${requestBlood.bloodNeedTime??""}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Hospital Name  :   ${requestBlood.hospitalName??""}',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Text(
                  'Hospital Location  :   ${requestBlood.hospitalLocation??""}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    'Patient Details  :   ${requestBlood.details??""}',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Requested By  - ${requestBlood.requestByName??""}',
                        style: fontStyle(15, textClrDLight, FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                requestBlood.isAccepted?
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Request Has been Accepted',
                      style: fontStyle(15, textClrLight, FontWeight.bold),
                    ),
                  ),
                ),)

                    :
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        height: 45,
                        minWidth: MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.all(12),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          updateRequestStatus(requestBlood.id.toString());
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Accept',
                          style: fontStyle(15, Colors.white, FontWeight.w600),
                        ),
                      ),
                      MaterialButton(
                        height: 45,
                        minWidth: MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.all(12),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Skip',
                          style: fontStyle(15, Colors.white, FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void updateRequestStatus(String documentId) async {
    final userId =AuthService.user!.uid;
    final userName =AuthService.user!.displayName;

    DocumentSnapshot userSnapshot =
    await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    // Check if the user document exists
    if (userSnapshot.exists) {
      // Cast the result of userSnapshot.data() to a Map<String, dynamic>
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

      // Get the bloodDonationDate from the user document
      Timestamp bloodDonationTimestamp = userData['bloodDonationDate'];

      // Calculate the current timestamp
      Timestamp currentTimestamp = Timestamp.now();

      // Calculate the difference in days between the current timestamp and bloodDonationDate
      int differenceInDays =
          currentTimestamp.toDate().difference(bloodDonationTimestamp.toDate()).inDays;

      // Check if the difference is greater than 90 days
      if (differenceInDays > 90) {
        try {
          await FirebaseFirestore.instance
              .collection('BloodRequest')
              .doc(documentId)
              .update({
            'isAccepted': true,
            'acceptedById': userId,
            'acceptedByName': userName,
          });
          fetchRequestBloodData();
          showMsg(context,"Request status updated successfully");
          print('Request status updated successfully');
        } catch (e) {
          print('Error updating request status: $e');
        }
      } else {
        showMsg(context,"Your last donate date is less than 90 days. You are not allowed to accept blood request.");

      }
    } else {
      showMsg(context,"There are no current user within this user id");

    }



  }

}
