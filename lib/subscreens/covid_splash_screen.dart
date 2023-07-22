import 'dart:async';

import 'package:doczone/subscreens/world_states.dart';
import 'package:flutter/material.dart';

class CovidSplashScreen extends StatefulWidget {
  const CovidSplashScreen({super.key});

  @override
  State<CovidSplashScreen> createState() => _CovidSplashScreenState();
}

class _CovidSplashScreenState extends State<CovidSplashScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const WorldStates()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/covidSs.gif',
          ),
        ),
      ),
    );
  }
}
