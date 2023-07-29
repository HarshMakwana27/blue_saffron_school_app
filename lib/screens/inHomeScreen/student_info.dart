// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                color: Theme.of(context).colorScheme.primary,
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
                        Text(
                          '${studentData['uid']}',
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.black,
                          width: .1,
                          height: 40,
                        ),
                        Text(
                          '${studentData['medium'].toString().capitalize()} \n Medium',
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.black,
                          width: 0.1,
                          height: 40,
                        ),
                        Text(studentData['gender'].toString().capitalize())
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
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
    );
  }
}
