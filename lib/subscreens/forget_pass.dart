import 'package:doczone/subscreens/choose_password.dart';
import 'package:doczone/subscreens/reset_passcode.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController phoneController = TextEditingController();

  Future<void> sendPasswordResetOTP(BuildContext context) async {
    try {
      final String phoneNumber = "+88${phoneController.text.trim()}";

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification is enabled and a verification is completed automatically
          // You can use the credential to sign in the user (if it's a new user) or link the credential with the existing user.
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          print(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPassCode(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Called when the code auto-retrieval times out
          // You can use the verificationId to manually verify the code using another method
        },
        timeout: Duration(seconds: 60), // Timeout duration for the OTP code
      );
    } catch (e) {
      // Handle send OTP errors
      print(e.toString());
    }
  }

  // void sendOTP(BuildContext context) async {
  //   String phoneNumber = phoneController.text.trim();
  //
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: "+88${phoneNumber}",
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ChoosePassword(phoneNumber:phoneNumber)
  //         ),
  //       );
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.message.toString(),style: TextStyle(color: Colors.white),),
  //         ),
  //       );
  //       print(e.message);
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ResetPassCode(
  //             phoneNumber: phoneNumber,
  //             verificationId: verificationId,
  //           ),
  //         ),
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }


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
                      value.length > 11 &&
                      value.length < 11) {
                    return 'Invalid Phone Number';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                    borderSide: const BorderSide(color: Colors.redAccent),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.redAccent),
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
                  onPressed: () => sendPasswordResetOTP(context),
                  child: Text(
                    'Send OTP',
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
