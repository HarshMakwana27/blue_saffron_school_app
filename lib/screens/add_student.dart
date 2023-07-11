import 'package:flutter/material.dart';
import 'package:school/model/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  void addStudent() async {
    Student newStudent = Student(
        key: '1',
        rollNumber: 1,
        name: 'Harsh',
        gender: Gender.male,
        medium: Medium.english,
        standard: Standard.KG1,
        joiningDate: DateTime.now());
    final url = Uri.https(
        'bluesaffron-d1ba1-default-rtdb.firebaseio.com', 'students-list.json');

    final response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode({
        'rollNo': newStudent.rollNumber,
        'name': newStudent.name,
        'gender': newStudent.gender.toString(),
        'medium': newStudent.medium.toString(),
        'standard': newStudent.standard.toString(),
        'joiningDate': newStudent.joiningDate.toIso8601String(),
      }),
    );
    print(response.statusCode);
    //print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a student"),
      ),
      body: Center(
        child: ElevatedButton(onPressed: addStudent, child: Text('add')),
      ),
    );
  }
}
