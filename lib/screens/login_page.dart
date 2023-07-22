import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doczone/subscreens/forget_pass.dart';
import 'package:doczone/subscreens/signup_page.dart';
import 'package:doczone/widgets/bottom_navbar.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../auth/auth_service.dart';
import '../subscreens/reset_via_email.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition();
  }

  Position? position;

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    determinePosition();
    getConnectivity();
    super.initState();
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isObscure = true;

  GlobalKey<FormState> loginKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: buttonClr,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.7,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: buttonClr,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: loginKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 30),
                              child: Text(
                                'Welcome',
                                style:
                                    fontStyle(32, textClrDark, FontWeight.bold),
                              ),
                            ),
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
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty && value.length < 7) {
                                    return 'Please enter a valid password';
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                obscureText: isObscure,
                                obscuringCharacter: '*',
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  prefixIcon: const Icon(Icons.key),
                                  prefixIconColor: buttonClr,
                                  hintText: 'Password',
                                  labelText: 'Password',
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const ForgetPassword(),
                                  //     ));

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const ResetPasswordViaEmail(),
                                      ));
                                },
                                child: Text(
                                  'Forgot password ?',
                                  style:
                                      fontStyle(16, buttonClr, FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: buttonClr,
                                height: 55,
                                minWidth: double.infinity,
                                onPressed: () {
                                  authenticate();

                                },
                                child: Text(
                                  'Login',
                                  style: fontStyle(
                                      16, textClrELight, FontWeight.w600),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account ?",
                                  style: fontStyle(
                                      16, textClrDark, FontWeight.w400),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage(),
                                        ));
                                  },
                                  child: Text(
                                    'Signup',
                                    style: fontStyle(
                                        16, buttonClr, FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );



  authenticate() async {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=>
            Center(child: CircularProgressIndicator(),)
    );

    if (loginKey.currentState!.validate()) {
      try {
        final status = await AuthService.login(emailController.text, passwordController.text);
        if(status) {
          print("Login Hoyche");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Successfully Logged In",style: TextStyle(color: Colors.white),),
            ),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);

          if(!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const BottomNavBar(),
            ),
          );        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Issues In Login",style: TextStyle(color: Colors.white),),
            ),
          );
          Navigator.pop(context);
          print("Login Hoy nai");
          await AuthService.logout();
          setState(() {

          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(e.message.toString(),
                style: TextStyle(color: Colors.white),),
            ),
          );
          Navigator.pop(context);

          print(e.message);

        });
      }
    }
  }
}
