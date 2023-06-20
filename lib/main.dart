import 'package:flutter/material.dart';
import 'package:school/home_screen.dart';
import 'package:school/splash_screen.dart';
import 'package:school/theme/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        home: const SplashScreen(),
        themeMode: ThemeMode.light);
  }
}
