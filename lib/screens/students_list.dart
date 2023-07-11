import 'package:flutter/material.dart';
import 'package:school/model/student.dart';
import 'package:school/widgets/student_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  var studentsList = [];
  String? _error;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  void _loadList() async {
    final url = Uri.https(
        'bluesaffron-d1ba1-default-rtdb.firebaseio.com', 'students-list.json');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          isLoading = false;
          _error = 'Failed to fetch data. Please try again later.';
        });
      }

      if (response.body == 'null') {
        setState(() {
          isLoading = false;
        });
        return;
      }

      print(response.body);
      final Map<String, dynamic> loadedList = json.decode(response.body);
      final List<Student> tempList = [];

      for (final item in loadedList.entries) {
        final Gender gender = item.value['gender'].toString() == 'Gender.male'
            ? Gender.male
            : Gender.female;
        final Medium medium =
            item.value['medium'].toString() == 'Medium.english'
                ? Medium.english
                : Medium.gujarati;
        final Standard standard =
            item.value['standard'].toString() == 'Standard.kg1'
                ? Standard.kg1
                : Standard.kg2;

        print(gender);
        tempList.add(
          Student(
            key: item.key,
            rollNumber: item.value['rollNo'],
            name: item.value['name'],
            gender: gender,
            medium: medium,
            standard: standard,
          ),
        );
        print(tempList.length);
      }

      setState(() {
        studentsList = tempList;

        isLoading = false;
      });
    } catch (error) {
      _error = ' Something went wrong';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('List is empty'));

    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    if (studentsList.isNotEmpty) {
      content = ListView.builder(
          itemCount: studentsList.length,
          itemBuilder: (context, index) => StudentTile(studentsList[index]));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Students List'),
        ),
        body: content);
  }
}
