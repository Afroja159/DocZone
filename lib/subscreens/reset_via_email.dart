import 'package:doczone/subscreens/choose_password.dart';
import 'package:doczone/subscreens/reset_passcode.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login_page.dart';

class ResetPasswordViaEmail extends StatefulWidget {
   const ResetPasswordViaEmail({super.key});

  @override
  State<ResetPasswordViaEmail> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ResetPasswordViaEmail> {
  TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {

    showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=>
    Center(child: CircularProgressIndicator(),)
    );

    try {
      // Send password reset email to the provided email
      await _auth.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Password Reset Email Sent.Please Check your email'),
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text( "Please check your email",
            style: TextStyle(color: Colors.white),),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
      // Show success message or navigate to a success page
    }on FirebaseAuthException catch (e) {


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text( "Error sending email to reset password",
            style: TextStyle(color: Colors.white),),
        ),
      );
      Navigator.pop(context);
      // Handle errors
      print('Error sending password reset email: $e');
      // Show error message
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Forgot Password ?',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            children: [
              Text(
                'Reset Password in two quick steps',
                style: fontStyle(15, textClrDark, FontWeight.w600),
              ),
              const SizedBox(height: 15),
              TextFormField(
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
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: buttonClr,
                  hintText: 'Email Address',
                  labelText: 'Email Address',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: buttonClr,
                  height: 55,
                  minWidth: double.infinity,
                  onPressed: () =>  resetPassword(emailController.text.trim()),
                  child: Text(
                    'Verify Email',
                    style: fontStyle(16, Colors.white, FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
