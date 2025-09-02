import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wedding_planner_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // white rakho taki image clean lage
      body: Center(
        child: Image.asset(
          "assets/images/hand-image.jpg", // <- tumhari image ka path
          fit: BoxFit.cover, // poori screen cover karegi
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
