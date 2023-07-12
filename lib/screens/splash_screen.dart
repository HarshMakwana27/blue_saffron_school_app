import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/blue_saffron_logo.png',
          width: width * 0.9,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
