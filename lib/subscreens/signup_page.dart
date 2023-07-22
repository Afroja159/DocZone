import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/screens/login_page.dart';
import 'package:doczone/subscreens/otp_screen.dart';
import 'package:doczone/utils/helper_functions.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../auth/auth_service.dart';
import '../models/user_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  List<String> genderItems = ['Male', 'Female'];
  List<String> bloodList = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String vId = '';
  String? selectedGender;
  String? selectedBlood;

  bool isObscure = true;

  GlobalKey<FormState> signupKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'SIGN UP',
                    style: fontStyle(24, buttonClr, FontWeight.w700),
                  ),
                ),
                Form(
                  key: signupKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              keyboardType: TextInputType.name,
                              controller: firstnameController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                icon: const Icon(
                                  Icons.person,
                                  color: buttonClr,
                                ),
                                hintText: 'Firstname',
                                labelText: 'Firstname',
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
                              keyboardType: TextInputType.name,
                              controller: lastnameController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                hintText: 'Lastname',
                                labelText: 'Lastname',
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
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty &&
                                !value.contains('@') &&
                                !value.contains('.com')) {
                              return 'Invalid E-mail Address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            prefixIcon: const Icon(Icons.mail),
                            prefixIconColor: buttonClr,
                            hintText: 'E-mail',
                            labelText: 'E-mail',
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
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
                            hintText: 'Phone Number',
                            labelText: 'Phone Number',
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
                      ),
                      // TextFormField(
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return '*required';
                      //     }
                      //     if (value.length < 13 && value.length > 17) {
                      //       return 'Invalid NID Number';
                      //     }

                      //     return null;
                      //   },
                      //   keyboardType: TextInputType.number,
                      //   controller: nidController,
                      //   decoration: InputDecoration(
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 10, horizontal: 15),
                      //     prefixIcon: const Icon(Icons.numbers),
                      //     prefixIconColor: buttonClr,
                      //     hintText: 'National ID Number',
                      //     labelText: 'National ID Number',
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //       borderSide: const BorderSide(color: buttonClr),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //       borderSide: const BorderSide(color: buttonClr),
                      //     ),
                      //     errorBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //       borderSide:
                      //           const BorderSide(color: Colors.redAccent),
                      //     ),
                      //     focusedErrorBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //       borderSide:
                      //           const BorderSide(color: Colors.redAccent),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '*required';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.streetAddress,
                          controller: locationController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            prefixIcon: const Icon(Icons.location_on),
                            prefixIconColor: buttonClr,
                            hintText: 'Present Address',
                            labelText: 'Present Address',
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
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*required';
                          }
                          return null;
                        },
                        controller: dobController,
                        keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          prefixIcon: const Icon(
                            Icons.cake,
                            color: buttonClr,
                          ),
                          hintText: 'Select Birth Date',
                          labelText: 'Select Birth Date',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: DropdownButtonFormField(
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
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            prefixIcon: const Icon(
                              Icons.warning,
                              color: buttonClr,
                            ),
                            hintText: 'Select Gender',
                            labelText: 'Select Gender',
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
                          onChanged: (genderValue) {
                            setState(() {
                              selectedGender = genderValue;
                            });
                          },
                        ),
                      ),
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
                        decoration: InputDecoration(
                          hintText: 'Choose Blood Group',
                          labelText: 'Choose Blood Group',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          prefixIcon: const Icon(
                            Icons.bloodtype,
                            color: buttonClr,
                          ),
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
                        onChanged: (bloodValue) {
                          setState(() {
                            selectedBlood = bloodValue;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password can't be Empty";
                            }
                            if (value.length < 8) {
                              return 'Password must contain atleast 8 Characters';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: isObscure,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            prefixIcon: const Icon(
                              Icons.key,
                              color: buttonClr,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                icon: isObscure == true
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            hintText: 'Password',
                            labelText: 'Password',
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
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value != passwordController.text.toString()) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        controller: confirmPassController,
                        obscureText: isObscure,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          prefixIcon: const Icon(
                            Icons.key,
                            color: buttonClr,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              icon: isObscure == true
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: MaterialButton(
                          height: 55,
                          minWidth: double.infinity,
                          color: buttonClr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () async{

                            if (signupKey.currentState!.validate()) {
                              showDialog(context: context,
                                  barrierDismissible: false,
                                  builder: (context)=>
                                      Center(child: CircularProgressIndicator(),)
                              );

                              Map<String,dynamic> registerData={
                                "firstName":firstnameController.text,
                                "lastName":lastnameController.text,
                                "email":emailController.text,
                                "phone":phoneController.text,
                                "address":locationController.text,
                                "dob":dobController.text,
                                "gender":selectedGender.toString(),
                                "blood":selectedBlood.toString(),
                                "password":passwordController.text,
                              };
                              final  fullName= "${firstnameController.text} ${lastnameController.text}";
                              bool isRegister = await AuthService.register(
                                  emailController.text, passwordController.text,
                                  fullName);
                              if(isRegister){

                                print("ami status er porer line");
                                if(mounted){
                                  print("create hoycehe");
                                  final userModel = UserModel(
                                    uid: AuthService.user!.uid,
                                    firstName:registerData["firstName"],
                                    lastname:registerData["lastName"],
                                    fullName: "${registerData["firstName"]} ${registerData["lastName"]}",
                                    email: registerData["email"],
                                    address: registerData["address"],
                                    dob: registerData["dob"],
                                    gender: registerData["gender"],
                                    bloodGroup: registerData["blood"],
                                    mobile: registerData["phone"],
                                    userCreationTime: Timestamp.fromDate(AuthService.user!.metadata.creationTime!),
                                  );
                                  if(!mounted) return;
                                  FirebaseFirestore _db = FirebaseFirestore.instance;
                                  await _db.collection("Users").doc(userModel.uid).set(userModel.toMap());
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                }

                              }
                              else{

                                // Navigator.of(context).popUntil((route) => route.isFirst);
                                showMsg(context, "The email address is already in use by another account");

                              }
                              Navigator.of(context).popUntil((route) => route.isFirst);

                            }

                          },
                          child: Text(
                            'Sign Up',
                            style:
                                fontStyle(16, textClrELight, FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account ?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'LogIn',
                              style: fontStyle(16, buttonClr, FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
