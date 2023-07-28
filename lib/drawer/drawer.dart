// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school/drawer/widgets/drawer_tile.dart';

import 'package:school/screens/inDrawer/about.dart';
import 'package:school/screens/inDrawer/add_student.dart';

import 'package:school/screens/inDrawer/gallary_screen.dart';
import 'package:school/screens/inDrawer/student_keys.dart';

import 'package:school/screens/inHomeScreen/splash_screen.dart';
import 'package:school/widgets/attendance_tile.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer(
      {super.key,
      required this.isStudent,
      required this.name,
      required this.uid});

  final int uid;

  final String name;

  final bool isStudent;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.8,
      child: Drawer(
        child: Column(children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
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
                    ),
                    Text(
                      name.capitalize(),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      isStudent ? '(Parent)' : '(Teacher)',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isStudent)
            const DrawerTile('Add new Student', Icons.add, AddStudent()),
          if (isStudent)
            const DrawerTile('Contact info', Icons.contact_page, AddStudent()),
          const DrawerTile('Gallary', Icons.image, GallaryScreen()),
          const DrawerTile('About', Icons.info, AboutScreen()),
          if (!isStudent) const DrawerTile('Keys', Icons.key, StudentKey()),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            horizontalTitleGap: 20,
            leading: const Icon(
              Icons.logout_rounded,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
            title: Text(
              'Log out',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 18),
            ),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                // After sign-out, navigate back to the login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              } catch (e) {
                print('Error occurred during sign-out: $e');
              }
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Made with ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 15,
                ),
                Text(
                  ' by Harsh Makwana',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
