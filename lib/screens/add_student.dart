import 'package:flutter/material.dart';
import 'package:school/model/student.dart';
import 'package:http/http.dart' as http;
import 'package:school/widgets/student_tile.dart';
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
  Gender? gender;
  Medium medium = Medium.english;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: 20,
              //   color: Theme.of(context).colorScheme.primary,
              // ),

              Row(
                children: [
                  Text(
                    'Medium : ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<Medium>(
                        value: medium,
                        items: [
                          DropdownMenuItem(
                            value: Medium.english,
                            child: Text(Medium.english.name.capitalize()),
                          ),
                          DropdownMenuItem(
                            value: Medium.gujarati,
                            child: Text(Medium.gujarati.name.capitalize()),
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            medium = value!;
                          });
                        }),
                  ),
                ],
              ),

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

              const Text('Gender of the student'),
              const SizedBox(
                height: 10,
              ),
              ToggleSwitch(
                minWidth: 70,
                initialLabelIndex: 1,
                minHeight: 25,
                cornerRadius: 7,
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
                    gender = Gender.male;
                  }
                  if (index == 1) {
                    gender = Gender.female;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: saveInfo, child: const Text("save"))
            ],
          ),
        ),
      ),
    );
  }
}
