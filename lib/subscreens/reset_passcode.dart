import 'package:doczone/subscreens/choose_password.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassCode extends StatefulWidget {
  String phoneNumber;
  String verificationId;
   ResetPassCode({super.key,required this.phoneNumber,required this.verificationId});

  @override
  State<ResetPassCode> createState() => _ResetPassCodeState();
}

class _ResetPassCodeState extends State<ResetPassCode> {
  TextEditingController codeController = TextEditingController();


  void _verifyOtp(BuildContext context) async {
    String otp = codeController.text.trim();

    // Create a PhoneAuthCredential using the verification ID and OTP
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      // Sign in the user with the phone credential
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Verified",style: TextStyle(color: Colors.white),),
              ),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChoosePassword(
              phoneNumber: widget.phoneNumber,
            ),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to verify OTP. Please try again.'),
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



  // void verifyOTP(BuildContext context) async {
  //   String otp = codeController.text.trim();
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: widget.verificationId,
  //     smsCode: otp,
  //   );
  //
  //   try {
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Verified",style: TextStyle(color: Colors.black),),
  //       ),
  //     );
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ChoosePassword(phoneNumber: widget.phoneNumber),
  //       ),
  //     );
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
            'Verification Code',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We sent a code to your Phone Number',
                style: fontStyle(17, textClrDark, FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                'Enter the 6-digit verification code sent to',
                style: fontStyle(16, textClrDark, FontWeight.w600),
              ),
              Text(
                widget.phoneNumber,
                style: fontStyle(16, textClrDark, FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty &&
                        value.length > 6 &&
                        value.length < 6) {
                      return 'Invalid Code';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  controller: codeController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    prefixIcon: const Icon(Icons.phone),
                    prefixIconColor: buttonClr,
                    hintText: '6 digit code',
                    labelText: '6 digit code',
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
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     'Resend code',
              //     style: fontStyle(16, buttonClr, FontWeight.bold),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: buttonClr,
                  height: 55,
                  minWidth: double.infinity,
                  onPressed: () => _verifyOtp(context),
                  child: Text(
                    'Verify OTP',
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
