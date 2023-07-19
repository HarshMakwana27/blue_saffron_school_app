import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:school/model/student.dart';

import 'package:school/widgets/student_tile.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final formKey = GlobalKey<FormState>();
  String? name;
  int? uid;
  Gender gender = Gender.male;
  Medium medium = Medium.english;
  Standard standard = Standard.kg1;

  bool isLoading = false;

  void isSuccessFun() {
    showDialog(
      context: context,
      barrierLabel: 'okay',
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Add more Students"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void isNotSuccessFun() {
    showDialog(
      context: context,
      barrierLabel: 'okay',
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
              const Text("Fail to add student"),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Try Again"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveInfo() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });

      final studentUuid = uuid.v4();

      try {
        await FirebaseFirestore.instance
            .collection('students')
            .doc('${medium.name}/${standard.name}/$uid')
            .set({
          'uuid': studentUuid,
          'uid': uid,
          'name': name,
          'gender': gender.name.toString(),
          'medium': medium.name.toString(),
          'standard': standard.name.toString(),
        });
        setState(() {
          isLoading = false;
          isSuccessFun();
        });
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? "Authentication Failed")));
        setState(() {
          isLoading = false;
        });
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
                Text(
                  'Academic Info',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                        },
                        decoration:
                            const InputDecoration(label: Text('Medium')),
                        icon: const Icon(Icons.abc_rounded),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
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
                        },
                        decoration:
                            const InputDecoration(label: Text('Standard')),
                        icon: const Icon(Icons.class_),
                      ),
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
                      icon: Icon(FontAwesomeIcons.idCard)),
                  keyboardType: TextInputType.number,
                  cursorWidth: 1,
                  validator: (value) {
                    if (int.tryParse(value!) == null) {
                      return 'Must be a number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    uid = int.tryParse(value!)!;
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
                    icon: Icon(
                      Icons.account_circle_rounded,
                      size: 28,
                    ),
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
                Row(
                  children: [
                    const Icon(
                      Icons.male_rounded,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    ToggleSwitch(
                      minWidth: 90,
                      initialLabelIndex: 0,
                      minHeight: 35,
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
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: saveInfo,
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary),
                            child: const Text("save"),
                          ),
                    TextButton(
                        onPressed: () {
                          formKey.currentState!.reset();
                        },
                        child: const Text("Reset")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
