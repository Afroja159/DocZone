import 'dart:async';

import 'package:doczone/auth/auth_service.dart';
import 'package:doczone/screens/login_page.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      AuthService.user == null?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage())):
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const BottomNavBar(),
        ),
      );
      ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/images/splashscreen.gif'),
        ),
      ),
    );
  }
}
