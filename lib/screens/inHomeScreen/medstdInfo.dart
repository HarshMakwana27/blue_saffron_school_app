// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school/screens/inHomeScreen/student_attendance.dart';
import 'package:school/screens/inHomeScreen/student_info.dart';

class MedStdforInfo extends StatefulWidget {
  const MedStdforInfo(
      {super.key, required this.uid, required this.forAttendance});

  final int uid;
  final bool forAttendance;

  @override
  State<MedStdforInfo> createState() => _MedStdforInfoState();
}

class _MedStdforInfoState extends State<MedStdforInfo> {
  String selectedMedium = 'english';
  String selectedStandard = 'kg1';

  Future<void> searchStudentData(int uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> studentDoc = await FirebaseFirestore
          .instance
          .collection('students')
          .doc(
              selectedMedium) // Assuming selectedMedium is either 'english' or 'gujarati'
          .collection(
              selectedStandard) // Assuming selectedStandard is either 'kg1' or 'kg2'
          .doc(uid.toString())
          .get();

      if (studentDoc.exists) {
        // Student data found, navigate to StudentInfo page with the data

        if (widget.forAttendance) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentAttendanceListScreen(
                  studentUID: widget.uid.toString(),
                  selectedMedium: selectedMedium,
                  selectedStandard: selectedStandard),
            ),
          );
          return;
        }

        final Map<String, dynamic> studentData = studentDoc.data()!;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentInfo(studentData: studentData),
          ),
        );
      } else {
        // Student data not found, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sorry, student data doesn't exist."),
          ),
        );
      }
    } catch (error) {
      // Error occurred while searching for data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student card'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Please Select your child's \nMedium and Standard",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Select medium:'),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 130,
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.center,
                  value: selectedMedium,
                  hint: const Text('Select Medium'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedMedium = newValue!;
                    });
                  },
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
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Select Standard:'),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 130,
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.center,
                  value: selectedStandard,
                  hint: const Text('Select Standard'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedStandard = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'kg1',
                      child: Text('KG1'),
                    ),
                    DropdownMenuItem(
                      value: 'kg2',
                      child: Text('KG2'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              searchStudentData(widget.uid);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(width * 0.8)),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
