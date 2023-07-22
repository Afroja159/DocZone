import 'package:doczone/auth/auth_service.dart';
import 'package:doczone/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_widget.dart';

class ChoosePassword extends StatefulWidget {
  String phoneNumber;
  ChoosePassword({Key? key,required this.phoneNumber}) : super(key: key);

  @override
  State<ChoosePassword> createState() => _ChoosePasswordState();
}

class _ChoosePasswordState extends State<ChoosePassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();
  bool isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorText;

  void _resetPassword(BuildContext context) async {
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmNewPassController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorText = 'Please enter both passwords';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        _errorText = 'Passwords do not match';
      });
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update the user's password
        await user.updatePassword(newPassword);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Password reset successful'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>LoginPage())
                   );
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to reset password. Please try again.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to reset password. Please try again.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }


  // void resetPassword(BuildContext context, String phoneNumber) async {
  //   String password = newPasswordController.text.trim();
  //   String confirmPassword = confirmNewPassController.text.trim();
  //
  //   if (password != confirmPassword) {
  //     // Handle password mismatch error
  //     return;
  //   }
  //
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       await user.updatePassword(password);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Successfully Reset",style: TextStyle(color: Colors.black),),
  //         ),
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => LoginPage(),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString(),style: TextStyle(color: Colors.black),),
  //       ),
  //     );
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'New Password',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SvgPicture.asset('assets/images/logo.svg'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Create a new password that is\nat least 8 characters long.',
                    textAlign: TextAlign.center,
                    style: fontStyle(15, textClrDark, FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),



                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty && value.length < 7) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    controller: newPasswordController,
                    obscureText: isObscure,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      prefixIcon: const Icon(Icons.key),
                      prefixIconColor: buttonClr,
                      hintText: 'New Password',
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure == true
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      suffixIconColor: buttonClr,
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
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value != newPasswordController.text.toString()) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                    controller: confirmNewPassController,
                    obscureText: isObscure,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      prefixIcon: const Icon(Icons.key),
                      prefixIconColor: buttonClr,
                      hintText: 'New Password',
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure == true
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      suffixIconColor: buttonClr,
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
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: buttonClr,
                    height: 55,
                    minWidth: double.infinity,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _resetPassword(context);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: fontStyle(16, Colors.white, FontWeight.w600),
                    ),
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
