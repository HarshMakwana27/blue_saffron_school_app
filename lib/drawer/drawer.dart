import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school/drawer/widgets/drawer_tile.dart';
import 'package:school/screens/about.dart';
import 'package:school/screens/add_student.dart';
import 'package:school/screens/gallary_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width);
    return Container(
      width: width * 0.8,
      child: Drawer(
        child: Column(children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary,
              ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(
                    //   Icons.school,
                    //   color: Colors.white,
                    //   size: 80,
                    // ),
                    // Text(
                    //   'Blue Saffron',
                    //   style: GoogleFonts.aBeeZee(),
                    // ),
                    // const Text(
                    //   'Pre-School',
                    //   style: TextStyle(color: Colors.white, fontSize: 20),
                    // ),
                    CircleAvatar(
                      radius: width * 0.1,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      child: Image.asset(
                        'assets/images/teacher.png',
                      ),
                    ),
                    const Text(
                      'Nehal Gohil',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const Text(
                      '(Pricipal)',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          DrawerTile('Gallary', Icons.image, GallaryScreen()),
          const DrawerTile('About', Icons.info, AboutScreen()),
          const DrawerTile('Add new Student', Icons.add, AddStudent())
        ]),
      ),
    );
  }
}
