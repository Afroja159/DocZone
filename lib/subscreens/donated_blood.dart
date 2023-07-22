
import 'package:doczone/subscreens/requested_blood_profile_view.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dbHelper/db_helper.dart';
import '../models/request_blood_model.dart';

class DonatedBlood extends StatefulWidget {
  const DonatedBlood({super.key});

  @override
  State<DonatedBlood> createState() => _DonatedBloodState();
}

class _DonatedBloodState extends State<DonatedBlood> {



  String uid = '';
  String firstName = '';
  String mobile = '';
  String lastName = '';
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
    fetchDonatedBloodData();
    super.initState();
  }

  void fetchDonatedBloodData()async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      showDialog(context: context,
          barrierDismissible: false,
          builder: (context)=>
              Center(child: CircularProgressIndicator(),)
      );
      List<RequestBloodModel> fetchRequestBlood = await DbHelper.fetchDonatedBloodData();
      setState(() {
        requestBloodModel = fetchRequestBlood;
      });
      Navigator.of(context).pop(); // Close the dialog

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Donated Blood List',
          style: fontStyle(23, textClrELight, FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [

              Expanded(
                child: ListView.builder(
                  itemCount: requestBloodModel.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    RequestBloodModel requestBlood = requestBloodModel[index];
                    DateTime currentTime = DateTime.now();
                    DateTime postTime = DateTime.parse(requestBlood.bloodNeedDate!);

                    Duration difference = postTime.difference(currentTime);
                    return InkWell(
                      onTap: () {
                        acceptInfo(requestBlood);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: ListTile(
                          tileColor: Colors.grey[100],
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
                          subtitle:   Text(
                            'Donated Date  :  ${
                                DateFormat("dd - MM - yyyy")
                                    .format(DateTime.parse(requestBlood.donatedBloodDate.toString().isNotEmpty?requestBlood.donatedBloodDate.toString():"No Date"))
                            }',
                            style: fontStyle(14, Colors.red, FontWeight.bold),
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
      ),
    );
  }
  acceptInfo(RequestBloodModel requestBlood) {
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
                Column(
                  children: [
                    Text(
                      'Requested By',
                      style: fontStyle(15, textClrDLight, FontWeight.w500),
                    ),
                    Text(
                      "${requestBlood.requestByName??""}",
                      style: fontStyle(18, textClrDark, FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestedBloodUserProfile(
                                requestedUserId:requestBlood.requestById.toString()
                            )));
                          },
                          child: Text(
                            'View Profile',
                            style: fontStyle(16, buttonClr, FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          width: 2,
                          height: 20,
                          color: buttonClr,
                        ),
                        IconButton(
                          onPressed: () async{

                            final Uri url = Uri(
                                scheme: 'tel',
                                path:
                                '${requestBlood.contactNumber}');

                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          icon: const Icon(
                            Icons.phone,
                            size: 22,
                            color: buttonClr,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                Text(
                  'Patient Name  :  ${requestBlood.patientName}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Patient Age  :   ${requestBlood.patientAge}',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Text(
                  'Blood Group  :   ${requestBlood.bloodGroup}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Number of Bags  :   ${requestBlood.numberOfBags}',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Text(
                  'Contact Number  :   ${requestBlood.contactNumber}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Date  :  ${
                        DateFormat("dd - MM - yyyy")
                            .format(DateTime.parse(requestBlood.bloodNeedDate!))
                    }',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Text(
                  'Time  :   ${requestBlood.bloodNeedTime}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Hospital Name  :   ${requestBlood.hospitalName}',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Text(
                  'Hospital Location  :   ${requestBlood.hospitalLocation}',
                  style: fontStyle(16, textClrDark, FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    'Patient Details  :   ${requestBlood.details}',
                    style: fontStyle(16, textClrDark, FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       MaterialButton(
                //         height: 45,
                //         minWidth: MediaQuery.of(context).size.width * 0.3,
                //         padding: const EdgeInsets.all(12),
                //         color: Colors.green,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         onPressed: () {
                //
                //           Navigator.pop(context);
                //         },
                //         child: Text(
                //           'Done',
                //           style: fontStyle(15, Colors.white, FontWeight.w600),
                //         ),
                //       ),
                //       MaterialButton(
                //         height: 45,
                //         minWidth: MediaQuery.of(context).size.width * 0.3,
                //         padding: const EdgeInsets.all(12),
                //         color: Colors.blue,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         onPressed: () {
                //           Navigator.pop(context);
                //         },
                //         child: Text(
                //           'Cancel',
                //           style: fontStyle(15, Colors.white, FontWeight.w600),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

}
