import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kColorScheme = ColorScheme(
  primary: Color.fromRGBO(54, 55, 137, 1),
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  secondary: Color.fromRGBO(90, 93, 187, 1),
  tertiary: Color.fromARGB(255, 37, 249, 26),
  brightness: Brightness.light,
  onSecondary: Color.fromARGB(255, 0, 0, 0),
  error: Colors.red,
  onError: Colors.black,
  onBackground: Color.fromARGB(255, 0, 0, 0),
  onSurface: Color.fromARGB(255, 0, 0, 0),
  background: Color.fromARGB(255, 255, 255, 255),
  surface: Color.fromARGB(255, 255, 255, 255),
);

const kDarkColorScheme = ColorScheme(
  primary: Color.fromRGBO(187, 134, 252, 1),
  onPrimary: Colors.black,
  secondary: Color.fromRGBO(3, 218, 197, 1),
  tertiary: Color.fromARGB(255, 37, 249, 26),
  brightness: Brightness.dark,
  onSecondary: Colors.black,
  error: Colors.redAccent,
  onError: Colors.black,
  onBackground: Colors.white,
  onSurface: Colors.white,
  background: Colors.black,
  surface: Colors.black,
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: kColorScheme,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(),
  appBarTheme: AppBarTheme(
    color: kColorScheme.background,
  ),
);

final darkTheme = ThemeData().copyWith(
    dividerColor: Colors.transparent,
    useMaterial3: true,
    colorScheme: kDarkColorScheme,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(),
    appBarTheme: AppBarTheme(
      color: kDarkColorScheme.background,
    ));

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
