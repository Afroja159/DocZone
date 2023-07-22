import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/subscreens/blood_doner_profile.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/auth_service.dart';
import '../dbHelper/db_helper.dart';
import '../models/user_model.dart';

class AvailableDonor extends StatefulWidget {
  const AvailableDonor({Key? key}) : super(key: key);

  @override
  State<AvailableDonor> createState() => _AvailableDonorState();
}

class _AvailableDonorState extends State<AvailableDonor> {
  bool isUploading = false;
  bool isSaving = false;

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

  String deviceToken = '';
  String userCreationTime = '';

  List<UserModel> userModel = [];
  List<UserModel> filteredUserModel = [];

  @override
  void initState() {
    fetchAvailableDonerData();
    super.initState();
  }

  void fetchAvailableDonerData() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
      List<UserModel> fetchedAvailableDoner = await DbHelper.fetchAvailableDonor();
      setState(() {
        userModel = fetchedAvailableDoner;
        filteredUserModel = fetchedAvailableDoner;
      });
      Navigator.pop(context);
    });
  }

  TextEditingController locationController = TextEditingController();
  TextEditingController rangeController = TextEditingController();

  List<String> bloodList = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  String? selectedBlood;

  void filterByBloodGroup() {
    setState(() {
      if (selectedBlood != null && selectedBlood!.isNotEmpty) {
        filteredUserModel = userModel.where((user) => user.bloodGroup == selectedBlood).toList();
      } else {
        filteredUserModel = userModel;
      }
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
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 10,
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*required';
                            }
                            return null;
                          },
                          value: selectedBlood,
                          items: bloodList.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            hintText: 'Blood Group',
                            labelText: 'Blood Group',
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
                          onChanged: (bloodValue) {
                            setState(() {
                              selectedBlood = bloodValue as String?;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: MaterialButton(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: buttonClr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: filterByBloodGroup,
                          child: const Icon(
                            Icons.search,
                            size: 30,
                            color: textClrELight,
                          ),
                        ),
                      ),
                    ],
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
              child: ListView.builder(
                itemCount: filteredUserModel.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  UserModel users = filteredUserModel[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: ListTile(
                      onTap: () {
                        donorInfo(users);
                      },
                      tileColor: Colors.yellow[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          users.bloodGroup ?? '',
                          style: fontStyle(16, textClrELight, FontWeight.w700),
                        ),
                      ),
                      title: Text(
                        users.fullName ?? '',
                        style: fontStyle(16, textClrDark, FontWeight.w700),
                      ),
                      trailing:  Text(
                        'View',
                        textAlign: TextAlign.center,
                        style: fontStyle(15, buttonClr, FontWeight.w600),
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

  donorInfo(UserModel users) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            users.fullName ?? '',
            textAlign: TextAlign.center,
            style: fontStyle(22, textClrDark, FontWeight.bold),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
          actions: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 2,
                  color: buttonClr,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Contact  :   ${users.mobile ?? ''}',
                      style: fontStyle(17, Colors.blue, FontWeight.w600),
                    ),
                    MaterialButton(
                      color: buttonClr,
                      shape: const CircleBorder(),
                      onPressed: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: '${users.mobile}',
                        );

                        if (await canLaunch(url.toString())) {
                          await launch(url.toString());
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.phone,
                          size: 18,
                          color: textClrELight,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 2,
              color: buttonClr,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: MaterialButton(
                height: 45,
                minWidth: MediaQuery.of(context).size.width * 0.35,
                padding: const EdgeInsets.all(12),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BloodDonerProfile(bloodDonerUserId: users.uid),
                    ),
                  );
                },
                child:  Text(
                  'View Details',
                  style: fontStyle(15, Colors.white, FontWeight.w700),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
