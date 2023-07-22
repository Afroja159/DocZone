import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/dbHelper/db_helper.dart';
import 'package:doczone/utils/helper_functions.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../auth/auth_service.dart';
import '../models/user_model.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {


  List<String> genderItems = ['Male', 'Female'];
  List<String> bloodList = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String vId = '';
  String? selectedGender;
  String? selectedBlood;



  XFile? imgPicker;


  bool isEditing = false;


  String? _imageUrl;
  String? _category;
  bool isUploading = false, isSaving = false;
  ImageSource _imageSource = ImageSource.camera;

  TextEditingController fullNameController =
  TextEditingController();
  TextEditingController emailController =
  TextEditingController();
  TextEditingController phoneController =
  TextEditingController();
  TextEditingController nidController =
  TextEditingController();
  TextEditingController locationController =
  TextEditingController();
  TextEditingController dobController =
  TextEditingController();

  TextEditingController genderController =
  TextEditingController();

  TextEditingController bloodController =
  TextEditingController();

  String uid = '';
  String firstName = '';
  String mobile = '';
  String lastName = '';
  String address = '';
  String dob = '';
  String gender = '';
  String image = '';
  String bloodGroup = '';

  String deviceToken = '';
  String userCreationTime = '';
  UserModel? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      String uid = AuthService.user!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          userData = UserModel.fromMap(data);

          this.uid = uid;
          // fullNameController.text = "${userData!.firstName??""} ${userData!.lastname??""}";
          fullNameController.text = userData!.fullName??"";
          phoneController.text = userData!.mobile??"";
          emailController.text = userData!.email??"";
          lastName = userData!.lastname??"";
          locationController.text = userData!.address??"";
          dobController.text = userData!.dob??"";
          selectedGender = userData!.gender??"";
          selectedBlood = userData!.bloodGroup??"";
          _imageUrl = userData!.image??"";
          deviceToken = userData!.deviceToken??"";
          userCreationTime = userData!.userCreationTime.toString()??"";
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
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: Container(
                color: textClrDark,
                child:
                Stack(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              // imageFrom();
                            },
                            child: Card(
                              elevation: 5,
                              child: _imageUrl == null
                                  ? isUploading
                                  ? const Center(
                                child: CircularProgressIndicator(),
                              )
                                  : Image.asset(
                                'assets/images/profile.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                                  : Image.network(
                                _imageUrl!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/loading.gif',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          isEditing
                              ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                imageFrom();
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: buttonClr,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 3,
                                    color: textClrELight,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: textClrELight,
                                ),
                              ),
                            ),
                          )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                )

              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: fontStyle(16, textClrDark, FontWeight.w600),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*required';
                          }
                          return null;
                        },
                        style: fontStyle(15, Colors.black54, FontWeight.w500),
                        enabled: isEditing,
                        keyboardType: TextInputType.name,
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrELight),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonClr),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrLight),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Text(
                        'Email',
                        style: fontStyle(16, textClrDark, FontWeight.w600),
                      ),
                      TextFormField(
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*required';
                          }
                          if (value.length < 11 && value.length > 11) {
                            return 'Invalid Email Address';
                          }

                          return null;
                        },

                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        style: fontStyle(15, Colors.black54, FontWeight.w500),
                        // enabled: isEditing,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrELight),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonClr),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrLight),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Gender',
                        style: fontStyle(16, textClrDark, FontWeight.w600),
                      ),

                      DropdownButtonFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*required';
                          }
                          return null;
                        },
                        value: selectedGender,
                        items: genderItems
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                            .toList(),

                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrELight),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonClr),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrLight),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                        isExpanded:isEditing,
                        onChanged: (genderValue) {
                          setState(() {
                            selectedGender = genderValue;
                          });
                        },
                      ),


                      // TextFormField(
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return '*required';
                      //     }
                      //     return null;
                      //   },
                      //   style: fontStyle(15, Colors.black54, FontWeight.w500),
                      //   enabled: isEditing,
                      //   keyboardType: TextInputType.name,
                      //   controller: genderController,
                      //   decoration: const InputDecoration(
                      //     contentPadding:
                      //     EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: textClrELight),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: buttonClr),
                      //     ),
                      //     disabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: textClrLight),
                      //     ),
                      //     errorBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.redAccent),
                      //     ),
                      //     focusedErrorBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.redAccent),
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(height: 10),
                      Text(
                        'Date Of Birth',
                        style: fontStyle(16, textClrDark, FontWeight.w600),
                      ),
                      // TextFormField(
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return '*required';
                      //     }
                      //     return null;
                      //   },
                      //   style: fontStyle(15, Colors.black54, FontWeight.w500),
                      //   enabled: isEditing,
                      //   keyboardType: TextInputType.name,
                      //   controller: dobController,
                      //   decoration: const InputDecoration(
                      //     contentPadding:
                      //     EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: textClrELight),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: buttonClr),
                      //     ),
                      //     disabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: textClrLight),
                      //     ),
                      //     errorBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.redAccent),
                      //     ),
                      //     focusedErrorBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.redAccent),
                      //     ),
                      //   ),
                      // ),

                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*required';
                          }
                          return null;
                        },
                        style: fontStyle(15, Colors.black54, FontWeight.w500),
                        controller: dobController,
                        keyboardType: TextInputType.none,
                        enabled: isEditing,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrELight),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonClr),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrLight),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());
                          if (pickedDate != null) {
                            setState(() {
                              dobController.text = DateFormat("dd - MM - yyyy")
                                  .format(pickedDate);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Blood Group',
                        style: fontStyle(16, textClrDark, FontWeight.w600),
                      ),
                      // TextFormField(
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return '*required';
                      //     }
                      //     return null;
                      //   },
                      //   style: fontStyle(15, Colors.black54, FontWeight.w500),
                      //   enabled: isEditing,
                      //   keyboardType: TextInputType.name,
                      //   controller: bloodController,
                      //   decoration: const InputDecoration(
                      //     contentPadding:
                      //     EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: textClrELight),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: buttonClr),
                      //     ),
                      //     disabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: textClrLight),
                      //     ),
                      //     errorBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.redAccent),
                      //     ),
                      //     focusedErrorBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.redAccent),
                      //     ),
                      //   ),
                      // ),


                      DropdownButtonFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
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

                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrELight),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonClr),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrLight),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                        isExpanded:isEditing,
                        onChanged: (bloodValue) {
                          setState(() {
                            selectedBlood = bloodValue;
                          });
                        },
                      ),

                      const SizedBox(height: 10),
                      Text(
                        'Phone Number',
                        style: fontStyle(16, textClrDark, FontWeight.w600),
                      ),
                      TextFormField(
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*required';
                          }
                          if (value.length < 11 && value.length > 11) {
                            return 'Invalid Phone Number';
                          }

                          return null;
                        },

                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        style: fontStyle(15, Colors.black54, FontWeight.w500),
                        enabled: isEditing,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrELight),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonClr),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrLight),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Text(
                        'Present Address',
                        style: fontStyle(16, textClrDark, FontWeight.w600),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*required';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.streetAddress,
                        controller: locationController,
                        style: fontStyle(15, Colors.black54, FontWeight.w500),
                        enabled: isEditing,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrELight),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonClr),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textClrLight),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      !isEditing ?   MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: buttonClr,
                        height: 55,
                        minWidth: double.infinity,
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                        child: Text(
                          'Edit Profile',
                          style: fontStyle(16, textClrELight, FontWeight.w600),
                        ),
                      ):MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: buttonClr,
                        height: 55,
                        minWidth: double.infinity,
                        onPressed: () {
                          _editProfile();
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                        child: Text(
                          'Save',
                          style: fontStyle(16, textClrELight, FontWeight.w600),
                        ),
                      )
                      ,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  imageFrom() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Option',
            style: fontStyle(18, buttonClr, FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                InkWell(
                  onTap: () {
                    _imageSource = ImageSource.camera;
                    _getImage();
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.camera,
                          color: buttonClr,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: fontStyle(14, textClrDark, FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _imageSource = ImageSource.gallery;
                    _getImage();
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.image,
                          color: buttonClr,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: fontStyle(14, textClrDark, FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  imageZoom() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: double.maxFinite,
            child: Image.file(
              File(imgPicker!.path),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }


  void _editProfile() async {
    String? id = AuthService.user!.uid;

    try {
      // Define the updated data
      Map<String, dynamic> updatedData = {
        'image': _imageUrl.toString(),
        'fullName': fullNameController.text.trim(),
        'gender': selectedGender.toString(),
        'dob': dobController.text.trim(),
        'bloodGroup': selectedBlood.toString(),
        'address': locationController.text.trim(),
      };

      // Update the user document
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .update(updatedData);
      //update auth user info
      await AuthService.user!.updateDisplayName(fullNameController.text.trim());

      showMsg(context, "Update successfully!");
      print('User details updated successfully');
    } catch (e) {
      showMsg(context, "Update Failed!");
      print('Error updating user details: $e');
    }
  }



  void _getImage() async {
    final selecteImage = await ImagePicker().pickImage(source: _imageSource);
    if (selecteImage != null) {
      setState(() {
        isUploading = true;
      });
      try {
        final url =
        await updateImage(selecteImage);
        setState(() {
          _imageUrl = url;
          isUploading = false;
        });
      } catch (e) {}
    }
  }

  Future<String> updateImage(XFile xFile) async {
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRef = FirebaseStorage.instance.ref().child('Pictures/$imageName');
    final uploadTask = photoRef.putFile(File(xFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  Widget _buildNetworkImage() {
    try {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        image: _imageUrl!,
        fadeInDuration: const Duration(seconds: 2),
        fadeInCurve: Curves.bounceInOut,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } catch (e) {
      print('Error loading image: $e');
      return Image.asset(
        'assets/images/error_image.png',
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    }
  }

}
