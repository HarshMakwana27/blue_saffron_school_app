import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:school/screens/auth/choose.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool isAnimation = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          isAnimation = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Timer(const Duration(seconds: 5), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    // });
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(seconds: 1),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: isAnimation
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))
                        : BorderRadius.zero),
                height: isAnimation ? height * 0.65 : height,
                child: Center(
                  child: Image.asset(
                    'assets/images/blue_saffron_logo.png',
                    width: width * 0.6,
                  ),
                ),
              ),
              Visibility(
                visible: isAnimation,
                child: const BottomPart(),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white);
  }
}

class BottomPart extends StatelessWidget {
  const BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Learning with fun !',
            style: GoogleFonts.comicNeue(
                fontSize: 30,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "A school To lay the foundation for a child's development",
            style: GoogleFonts.comicNeue(
                fontSize: 12, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(
            height: 60,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (ctx) {
                  return const ChooseCategory();
                }));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width * 0.9, 50),
                foregroundColor: Colors.white,
              ),
              child: const Text('Get Started !')),
        ],
      ),
    );
  }
}

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Image.asset(
          'assets/images/blue_saffron_logo.png',
          width: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
}
