import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:school/screens/inHomeScreen/home_screen.dart';
import 'package:school/screens/inHomeScreen/splash_screen.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school/theme/themes.dart';

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
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen2();
              }
              return const SplashScreen();
            }),
        themeMode: ThemeMode.light);
  }
}
