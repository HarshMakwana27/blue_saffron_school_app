import 'package:flutter/material.dart';
import 'package:school/model/student.dart';
import 'package:school/widgets/student_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Student> studentsList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students List'),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return const StudentTile();
          }),
    );
  }
}
