// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school/screens/inHomeScreen/student_attendance.dart';
import 'package:school/screens/inHomeScreen/student_info.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({
    super.key,
    required this.uid,
    required this.selectedMedium,
    required this.selectedStandard,
  });

  final int uid;
  final String selectedMedium;
  final String selectedStandard;

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  Future<void> fetchStudentData(int uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> studentDoc = await FirebaseFirestore
          .instance
          .collection('students')
          .doc(widget
              .selectedMedium) // Assuming selectedMedium is either 'english' or 'gujarati'
          .collection(widget
              .selectedStandard) // Assuming selectedStandard is either 'kg1' or 'kg2'
          .doc(uid.toString())
          .get();

      if (studentDoc.exists) {
        // Student data found, navigate to StudentInfo page with the data

        final Map<String, dynamic> studentData = studentDoc.data()!;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StudentInfo(studentData: studentData),
          ),
        );
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Student data not found, please make sure you are entering correct medium and standard'),
          ),
        );
        // Student data not found, show a message
      }
    } catch (error) {
      // Error occurred while fetching for data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    fetchStudentData(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
