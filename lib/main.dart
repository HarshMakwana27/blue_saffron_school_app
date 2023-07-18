import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:school/screens/home_screen.dart';
import 'firebase_options.dart';

import 'package:school/screens/splash_screen.dart';
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
        theme: theme,
        darkTheme: darkTheme,
        home: SplashScreen(),
        themeMode: ThemeMode.light);
  }
}
