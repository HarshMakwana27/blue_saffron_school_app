import 'package:flutter/material.dart';
import 'package:school/model/student.dart';
import 'package:http/http.dart' as http;
import 'package:school/screens/home_screen.dart';
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
  String? name;
  int? rollNo;
  Gender? gender;
  Medium medium = Medium.english;
  Standard standard = Standard.kg1;

  bool isLoading = false;

  void saveInfo() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isLoading = true;

      final url = Uri.https('bluesaffron-d1ba1-default-rtdb.firebaseio.com',
          'students-list.json');

      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'rollNo': rollNo,
          'name': name,
          'gender': gender.toString(),
          'medium': medium.toString(),
          'standard': standard.toString(),
        }),
      );
      print(response.statusCode);

      if (!context.mounted) {
        return;
      }

      if (response.statusCode >= 400) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          barrierLabel: 'okay',
          builder: (context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18, left: 10, right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 70,
                  ),
                  Text("Failed",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.red)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("'Try again later'"),
                ],
              ),
            ),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          barrierLabel: 'okay',
          builder: (context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18, left: 10, right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 70,
                  ),
                  Text("Success",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.green)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("'Student added to the list'"),
                ],
              ),
            ),
          ),
        );
      }
    }
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
      body: SingleChildScrollView(
        child: Form(
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
                Text(
                  'Academic Info',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Medium : ',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<Medium>(
                          value: medium,
                          isDense: true,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Standard : ',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 43,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<Standard>(
                          alignment: Alignment.bottomCenter,
                          value: standard,
                          isDense: true,
                          items: const [
                            DropdownMenuItem(
                              value: Standard.kg1,
                              child: Text('Kg 1'),
                            ),
                            DropdownMenuItem(
                              value: Standard.kg2,
                              child: Text('Kg 2'),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              standard = value!;
                            });
                          }),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                Text(
                  'Personal Info',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
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
      ),
    );
  }
}
