import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:school/drawer/drawer.dart';
import 'package:school/main.dart';
import 'package:school/screens/inHomeScreen/announce.dart';
import 'package:school/screens/inHomeScreen/attendance_list.dart';
import 'package:school/screens/inHomeScreen/contact.dart';
import 'package:school/screens/inHomeScreen/fetch_screen.dart';
import 'package:school/screens/inHomeScreen/student_attendance.dart';
import 'package:school/screens/inHomeScreen/students_list.dart';
import 'package:school/screens/inHomeScreen/takeattendance.dart';
import 'package:school/widgets/construction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final date = DateFormat('dd').format(DateTime.now());
  final month = DateFormat('MMMM').format(DateTime.now());
  final day = DateFormat('EEEE').format(DateTime.now());

  String _selectedMedium = 'english';
  String _selectedStandard = 'kg1';

  final firebaseAuthUid = kfirebaseauth.currentUser!.uid;

  int? uid;
  String? name;
  bool? isStudent;

  late Future<int> flag;

  Future<int> fetchUserData() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuthUid)
          .get();

      isStudent = userSnapshot.data()!['isStudent'];
      uid = userSnapshot.data()!['uid'];
      name = userSnapshot.data()!['name'];

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
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: height * 0.02),
          padding: const EdgeInsets.only(
            top: 5,
            left: 10,
            bottom: 15,
          ),
          height: height * 0.37,
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
              const SizedBox(
                height: 10,
              ),
              Text(
                '$date $month',
                style: const TextStyle(fontSize: 15, color: Colors.white),
                textAlign: TextAlign.start,
              ),
              Text(
                day,
                style: GoogleFonts.aboreto(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    wordSpacing: 3,
                    letterSpacing: 1.5),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3)),
                      shape: BoxShape.rectangle,
                      border: Border(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      day == 'Sunday' ? 'Holiday' : 'School Day',
                      style: GoogleFonts.aboreto(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/images/schoolday.png',
                  alignment: Alignment.bottomLeft,
                  height: height * 0.15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.02),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.45,
                child: DropdownButtonFormField(
                  value: _selectedMedium,
                  decoration: const InputDecoration(
                    labelText: 'Medium',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'english',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'gujarati',
                      child: Text('Gujarati'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedMedium = value!;
                    });
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: width * 0.45,
                child: DropdownButtonFormField(
                  value: _selectedStandard,
                  decoration: const InputDecoration(
                    labelText: 'Standard',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'kg1',
                      child: Text('Kg1'),
                    ),
                    DropdownMenuItem(
                      value: 'kg2',
                      child: Text('KG2'),
                    ),
                    DropdownMenuItem(
                      value: 'nursery',
                      child: Text('Nursery'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStandard = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
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
                        if (!isStudent!)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => TakeAttendance(
                                    selectedMedium: _selectedMedium,
                                    selectedStandard: _selectedStandard),
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
                        if (!isStudent!)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => StudentList(
                                    selectedMedium: _selectedMedium,
                                    selectedStandard: _selectedStandard),
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
                        if (!isStudent!)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => Attendancelist(
                                  selectedMedium: _selectedMedium,
                                  selectedStandard: _selectedStandard,
                                ),
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
                        if (isStudent!)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => StudentAttendanceListScreen(
                                  studentUID: uid.toString(),
                                  selectedMedium: _selectedMedium,
                                  selectedStandard: _selectedStandard,
                                ),
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
                                      child: Image.asset(
                                        'assets/images/students.png',
                                        width: 50,
                                      )),
                                  const Text(
                                    "Check attendance",
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
                        if (isStudent!)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const Construction(),
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
                                      child: Image.asset(
                                          'assets/images/performance.png')),
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
                                  child: Image.asset(
                                    'assets/images/announcement.png',
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => Contact(isStudent: isStudent!),
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
                                  child: Image.asset(
                                    'assets/images/contact.png',
                                  ),
                                ),
                                const Text(
                                  "Contact",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isStudent!)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => FetchScreen(
                                  uid: uid!,
                                  selectedMedium: _selectedMedium,
                                  selectedStandard: _selectedStandard,
                                ),
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
                                    child: Image.asset(
                                      'assets/images/id.png',
                                      width: 50,
                                      height: 50,
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
      drawer: FutureBuilder<Object>(
          future: flag,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            } else {
              return MainDrawer(
                isStudent: isStudent!,
                name: name!,
                uid: uid!,
              );
            }
          }),
    );
  }
}
