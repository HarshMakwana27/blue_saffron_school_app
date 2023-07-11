import 'package:flutter/material.dart';
import 'package:school/model/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toggle_switch/toggle_switch.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  int rollNo = 0;

  void saveInfo() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.reset();
    }
  }

  void addStudent() async {
    Student newStudent = Student(
      key: '1',
      rollNumber: 1,
      name: 'Harsh',
      gender: Gender.male,
      medium: Medium.english,
      standard: Standard.kg1,
    );
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
      }),
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a student",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              // Container(
              //   height: 20,
              //   color: Theme.of(context).colorScheme.primary,
              // ),

              TextFormField(
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  label: Text('Roll number'),
                ),
                keyboardType: TextInputType.number,
                cursorWidth: 1,
                validator: (value) {
                  if (int.tryParse(value!) == null) {
                    return 'Must be a number';
                  }
                  return null;
                },
                onSaved: (value) {
                  rollNo = int.tryParse(value!)!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 35,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  label: Text('Name of the student'),
                ),
                keyboardType: TextInputType.name,
                cursorWidth: 1,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name can not be empty';
                  }
                  if (value.length <= 1) {
                    return 'Name must be between 1 to 35 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),

              ToggleSwitch(
                minWidth: 90.0,
                initialLabelIndex: 1,
                minHeight: 35,
                cornerRadius: 10,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: const ['Boy', 'Girl'],
                activeBgColors: const [
                  [Colors.blue],
                  [Colors.pink]
                ],
                onToggle: (index) {
                  if (index == 0) {
                    print('boy');
                  }
                  if (index == 1) {
                    print('girl');
                  }
                },
              ),
              ElevatedButton(onPressed: saveInfo, child: const Text("save"))
            ],
          ),
        ),
      ),
    );
  }
}
