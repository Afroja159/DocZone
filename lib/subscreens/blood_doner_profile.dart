import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/dbHelper/db_helper.dart';
import 'package:doczone/utils/helper_functions.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/auth_service.dart';
import '../models/user_model.dart';

class BloodDonerProfile extends StatefulWidget {
  final String bloodDonerUserId;

  BloodDonerProfile({required this.bloodDonerUserId});

  @override
  _RequestedBloodUserProfileState createState() =>
      _RequestedBloodUserProfileState();
}

class _RequestedBloodUserProfileState extends State<BloodDonerProfile> {
  UserModel? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.bloodDonerUserId)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          userData = UserModel.fromMap(data);
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            userData != null
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: userData!.image != null
                                ? NetworkImage(userData!.image!)as ImageProvider
                                : AssetImage('assets/images/profile.png'), // Replace 'path_to_placeholder_image' with the actual path to your placeholder image asset
                          ),
                        ),
                        child: userData!.image == null
                            ? Center(
                          child: Text(
                            'No Image',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                            : null,
                      ),
                    ),

                    // Center(
                    //   child: Container(
                    //     width: 150,
                    //     height: 150,
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(
                    //             userData!.image ?? '',
                    //           ) as ImageProvider),
                    //     ),
                    //
                    //   ),
                    // ),
                    Divider(
                      height: 60,
                      color: Colors.grey[800],
                    ),
                    Text(
                      'Name',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      userData!.fullName??"",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Date Of Birth : ${userData!.dob.toString()}",
                      style: TextStyle(
                          color: Colors.grey[600], fontSize: 15, letterSpacing: 1),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Blood',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            Text(
                              userData!.bloodGroup??"",
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Gender',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            Text(
                              userData!.gender??"",
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Last Blood Donate',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${userData!.bloodDonationDate?.toDate().day}-"
                                  "${userData!.bloodDonationDate?.toDate().month}-"
                                  "${userData!.bloodDonationDate?.toDate().year} ",
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 60,
                      color: Colors.grey[800],
                    ),


                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone_android_outlined,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          userData!.mobile??"",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          userData!.email??"",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.place_sharp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          userData!.address??"",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

}
