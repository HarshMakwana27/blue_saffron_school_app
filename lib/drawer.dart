import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school/gallary_screen.dart';

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
                    Expanded(
                        child: Image.asset(
                      'assets/images/blue_saffron_logo.png',
                      width: width * 0.7,
                    ))
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            horizontalTitleGap: 20,
            leading: const Icon(
              Icons.image,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
            title: Text(
              'Gallary',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GallaryScreen()));
            },
          ),
        ]),
      ),
    );
  }
}
