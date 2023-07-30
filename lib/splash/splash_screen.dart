import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/home/home_screen.dart';
import 'package:quiz_app/home/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 2),
            () =>
            //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) => const MainScreen()), (route) => false));
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.blue.shade200,
        child: Center(
          child: Text(
              "Quiz \nKnowledge",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.black.withOpacity(0.75)),
          ),
        ),
      ),
    );
  }
}
