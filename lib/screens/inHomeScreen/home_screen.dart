import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:school/drawer/drawer.dart';
import 'package:school/main.dart';

import 'package:school/screens/inHomeScreen/announce.dart';
import 'package:school/screens/inHomeScreen/attendance_list.dart';

import 'package:school/screens/inHomeScreen/stepper.dart';
import 'package:school/screens/inHomeScreen/student_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final date = DateFormat('dd').format(DateTime.now());
  final month = DateFormat('MMMM').format(DateTime.now());
  final day = DateFormat('EEEEEEEEEE').format(DateTime.now());

  final firebaseAuthUid = kfirebaseauth.currentUser!.uid;

  int uid = 0;
  String name = 'username';
  bool isStudent = true;

  late Future<int> flag;

  Future<int> fetchUserData() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuthUid)
          .get();
      setState(() {
        isStudent = userSnapshot.data()!['isStudent'];
        uid = userSnapshot.data()!['uid'];
        name = userSnapshot.data()!['name'];
      });

      return 0;
    } catch (error) {
      return 1;
    }
  }

  @override
  void initState() {
    flag = fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 290,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                date,
                style: const TextStyle(fontSize: 40, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                month,
                style: const TextStyle(fontSize: 15, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 100,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
              Text(
                day,
                style: GoogleFonts.aboreto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    wordSpacing: 3,
                    letterSpacing: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Studying Day',
                style: GoogleFonts.aboreto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    wordSpacing: 3,
                    letterSpacing: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
            child: FutureBuilder<int>(
                future: flag,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Failed to fetch Data'));
                    }
                    return GridView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      children: [
                        if (!isStudent)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const StepperCode(0),
                              ));
                            },
                            child: Card(
                              shadowColor:
                                  Theme.of(context).colorScheme.onBackground,
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 55,
                                    height: 55,
                                    child: Image.asset(
                                      'assets/images/students.png',
                                      width: 50,
                                    ),
                                  ),
                                  const Text(
                                    'Take Attendance',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!isStudent)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const StepperCode(1),
                              ));
                            },
                            child: Card(
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 55,
                                    height: 55,
                                    child: const Icon(
                                      Icons.people_outline,
                                      size: 50,
                                    ),
                                  ),
                                  const Text(
                                    'Students list',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!isStudent)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const Attendancelist(),
                              ));
                            },
                            child: Card(
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 55,
                                    height: 55,
                                    child: const Icon(
                                      Icons.list_rounded,
                                      size: 50,
                                    ),
                                  ),
                                  const Text(
                                    'Attendance List',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (isStudent)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const Attendancelist(),
                              ));
                            },
                            child: Card(
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 55,
                                    height: 55,
                                    child: const Icon(
                                      Icons.bar_chart_sharp,
                                      size: 50,
                                    ),
                                  ),
                                  const Text(
                                    "Student's attendance",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (isStudent)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const StudentInfo(),
                              ));
                            },
                            child: Card(
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 55,
                                    height: 55,
                                    child: const Icon(
                                      Icons.pie_chart_rounded,
                                      size: 50,
                                    ),
                                  ),
                                  const Text(
                                    "Performance",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const Announcement(),
                            ));
                          },
                          child: Card(
                            surfaceTintColor:
                                Theme.of(context).colorScheme.background,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 55,
                                  height: 55,
                                  child: const Icon(
                                    CupertinoIcons.group,
                                    size: 50,
                                  ),
                                ),
                                const Text(
                                  "Announcements",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isStudent)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const StudentInfo(),
                              ));
                            },
                            child: Card(
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 55,
                                    height: 55,
                                    child: const Icon(
                                      CupertinoIcons.profile_circled,
                                      size: 50,
                                    ),
                                  ),
                                  const Text(
                                    "Profile",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                }))
      ]),
      drawer: MainDrawer(
        isStudent: isStudent,
        name: name,
        uid: uid,
      ),
    );
  }
}