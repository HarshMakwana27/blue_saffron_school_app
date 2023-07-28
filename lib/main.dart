import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:school/screens/inHomeScreen/home_screen.dart';
import 'package:school/screens/inHomeScreen/splash_screen.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school/theme/themes.dart';

var kfirebaseauth = FirebaseAuth.instance;
var kdbref = FirebaseDatabase.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: StreamBuilder(
            stream: kfirebaseauth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen2();
              } else {
                final user = snapshot.data;
                if (user != null) {
                  // User is authenticated, show the HomeScreen
                  return const HomeScreen();
                } else {
                  // User is not authenticated, show the SplashScreen
                  return const SplashScreen();
                }
              }
            }),
        themeMode: ThemeMode.light);
  }
}
