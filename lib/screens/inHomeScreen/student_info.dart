// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/screens/inHomeScreen/contact.dart';
import 'package:school/screens/inHomeScreen/student_attendance.dart';

import 'package:school/widgets/attendance_tile.dart';

class StudentInfo extends StatelessWidget {
  final Map<String, dynamic> studentData;
  const StudentInfo({
    required this.studentData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        alignment: const Alignment(0, -1),
        children: [
          Column(
            children: [
              Container(
                height: height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Container(
            height: height * 0.33,
            width: width * 0.9,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                //  color: Colors.amber,
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.065),
              child: Container(
                // width: width * 0.9,
                // height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.086,
                    ),
                    Text(
                      studentData['name'].toString().capitalize(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      studentData['standard'],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      color: Colors.black,
                      height: 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Medium',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: height * 0.006,
                            ),
                            Text(studentData['medium'].toString().capitalize())
                          ],
                        ),
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.black,
                          width: .1,
                          height: height * 0.05,
                        ),
                        Column(
                          children: [
                            Text(
                              'Uid',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: height * 0.006,
                            ),
                            Text(
                              '${studentData['uid']}',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.black,
                          width: 0.1,
                          height: 40,
                        ),
                        Column(
                          children: [
                            Text(
                              'Gender',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: height * 0.006,
                            ),
                            Text(
                              '${studentData['gender']}',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            foregroundImage: NetworkImage(studentData['imageurl']),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.36, left: width * 0.05, right: width * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    shadowColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'GR number : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              Text(
                                " ${studentData["grnumber"].toString().capitalize()}",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Father : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              Text(
                                " ${studentData["father's name"].toString().capitalize()} ${studentData["surname"].toString().capitalize()}",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Mother : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              Text(
                                " ${studentData["mother's name"].toString().capitalize()} ${studentData["surname"].toString().capitalize()}",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Date of birth : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              Text(
                                " ${studentData["dob"].toString().capitalize()}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return StudentAttendanceListScreen(
                            studentUID: studentData['uid'],
                            selectedMedium: studentData['medium'],
                            selectedStandard: studentData['standard']);
                      }));
                    },
                    child: Card(
                        shape: const StadiumBorder(),
                        surfaceTintColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Attandance Information",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Contact(isStudent: false);
                      }));
                    },
                    child: Card(
                        shape: const StadiumBorder(),
                        surfaceTintColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Contact Information",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
