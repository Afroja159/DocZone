import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../auth/auth_service.dart';
import '../configure/app_colors.dart';
import '../models/user_model.dart';
import '../screens/login_page.dart';
import '../widgets/custom_widget.dart';

class OtpMatchScreen extends StatefulWidget {
  Map<String,dynamic> registerData;
  OtpMatchScreen({Key? key, required this.registerData}) : super(key: key);

  @override
  State<OtpMatchScreen> createState() => _OtpMatchScreenState();
}

class _OtpMatchScreenState extends State<OtpMatchScreen> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  bool isFirst = true;
  String vId = '';
  String? verificationCode;
  int resendToken = 0;



  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }


  void _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+88${widget.registerData['phone']}",
      verificationCompleted: (PhoneAuthCredential credential) {
        _signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Verification Failed",style: TextStyle(color: Colors.white),),
          ),
        );

        print('Verification Failed: ${e.message}');
      },
      codeSent: (String vID,int? recenToken){
        assert(vID != null);
        setState(() {
          verificationCode = vID;
          resendToken=resendToken;
          print("verification id holo-------------------------------$verificationCode");
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }

  void _signInWithCredential(PhoneAuthCredential credential) async {

    showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=>
            Center(child: CircularProgressIndicator(),)
    );
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User authentication successful",style: TextStyle(color: Colors.white),),
          ),
        );
        // User is successfully authenticated
        print('User authentication successful');
       final  fullName= "${widget.registerData["firstName"]} ${widget.registerData["lastName"]}";
        if(await AuthService.register(
            widget.registerData["email"], widget.registerData["password"],
            fullName)){

          print("ami status er porer line");
          if(mounted){
            print("create hoycehe");
            final userModel = UserModel(
              uid: AuthService.user!.uid,
              firstName: widget.registerData["firstName"],
              lastname: widget.registerData["lastName"],
              fullName: "${widget.registerData["firstName"]} ${widget.registerData["lastName"]}",
              email: widget.registerData["email"],
              address: widget.registerData["address"],
              dob: widget.registerData["dob"],
              gender: widget.registerData["gender"],
              bloodGroup: widget.registerData["blood"],
              mobile: widget.registerData["phone"],
              userCreationTime: Timestamp.fromDate(AuthService.user!.metadata.creationTime!),
            );
            if(!mounted) return;
            FirebaseFirestore _db = FirebaseFirestore.instance;
            await _db.collection("Users").doc(userModel.uid).set(userModel.toMap());
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
        }
        Navigator.of(context).popUntil((route) => route.isFirst);

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User authentication failed",style: TextStyle(color: Colors.white),),
          ),
        );
        Navigator.pop(context);
        // User authentication failed
        print('User authentication failed');
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error signing in with phone credential",style: TextStyle(color: Colors.white),),
        ),
      );
      Navigator.pop(context);

      print('Error signing in with phone credential: $e');
    }
  }

  void _verifyOTP() {
    String pin = otpController.text;
    PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
      verificationId: verificationCode!,
      smsCode: pin,
    );
    _signInWithCredential(phoneCredential);
  }


  void _resendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+88${widget.registerData['phone']}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Verification failed",style: TextStyle(color: Colors.black),),
          ),
        );
        // Handle verification failure
        print('Verification Failed: ${e.message}');
      },
      codeSent: (String verificationId, int? token) {
        setState(() {
          verificationCode = verificationId;
          resendToken=resendToken;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 60),
      forceResendingToken: resendToken,
    );
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return   Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h*0.08,),
            const Text('\nVerify your phone number',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: '\nWe Send OTP: '),
                  TextSpan(
                    text: "+88${widget.registerData['phone']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),

            const Text('\nEnter your otp code here.\n\n',
              style: TextStyle(
                  fontWeight: FontWeight.w500
              ),
            ),


            Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: TextField(
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 20,letterSpacing: 36, fontWeight: FontWeight.bold),
                  maxLength: 6,

                  decoration: InputDecoration(
                    counter: Offstage(),
                    hintText: 'Enter 6 Digits OTP',
                    fillColor: Color(0xFFffffff),
                    filled: true,
                    labelStyle: const TextStyle(fontSize: 16),
                    hintStyle: const TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.w100),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(0xFFfffff),
                          width: 2
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFfffff),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(top: 5,left: 15, bottom: 5),
                  ),
                )
            ),

            const Text("\nDidn't you receive any code? Wait!\n",
              style: TextStyle(fontSize: 15,
                  letterSpacing: 1),),

        CircularCountDownTimer(
          duration: 60,
          initialDuration: 0,
          controller: CountDownController(),
          width: 80,
          height: 80,
          ringColor: Colors.grey[300]!,
          ringGradient: null,
          fillColor: AppColors.primaryColor.withOpacity(0.4),
          fillGradient: null,
          backgroundColor: AppColors.primaryColor,
          backgroundGradient: null,
          strokeWidth: 20.0,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(
            fontSize: 33.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: true,
          isTimerTextShown: true,
          autoStart: true,
          onStart: () {
            debugPrint('Countdown Started');
          },
          onComplete: () {
            debugPrint('Countdown Ended');
            // Handle countdown completion, such as displaying a "Resend OTP" button
          },
        ),

            /// Resend OTP Button
            SizedBox(height: h*0.15,),
            GestureDetector(
              onTap: (){
                // CountDownController().restart();
                // _resendOTP();
              },
              child: const Text("\nResend OTP\n",
                style: TextStyle(fontSize: 15,
                    letterSpacing: 1),),
            ),

            SizedBox(height: 16.0),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: buttonClr,
                height: 55,
                minWidth: double.infinity,
                onPressed: () {

                  _verifyOTP();

                },
                child: Text(
                  'Verify OTP',
                  style: fontStyle(
                      16, textClrELight, FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),


      // bottomNavigationBar: loginController.press.isFalse ?
      // AppWidgets().submitButton(context, text: 'Verify', press: (){
      //   if(currentText != ''){
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
      //
      //   } else {
      //     AppWidgets().wrongSnackBar(context, 'Please Enter an OTP');
      //   }
      // }) : Padding(
      //   padding: EdgeInsets.symmetric(vertical: h*0.03, horizontal: w*0.45),
      //   child: const CircularProgressIndicator(),
      // ),
    );

  }



}