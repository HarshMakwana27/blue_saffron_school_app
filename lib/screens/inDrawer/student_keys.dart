// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _db = FirebaseDatabase.instance;

enum UserOption { student, teacher }

class StudentKey extends StatefulWidget {
  const StudentKey({super.key});

  @override
  State<StudentKey> createState() => _StudentKeyState();
}

class _StudentKeyState extends State<StudentKey> {
  final formKey = GlobalKey<FormState>();

  int? uid;
  int? key;
  UserOption? selectedOption;

  bool isLoading = false;

  // Existing success and failure dialogs remain unchanged.

  void saveInfo() async {
    if (formKey.currentState!.validate() && selectedOption != null) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });

      try {
        if (selectedOption == UserOption.student) {
          // Save Student UID and Key
          await _db.ref('students/$uid').set({'key': key});
          Navigator.of(context).pop();
        } else if (selectedOption == UserOption.teacher) {
          // Save Teacher UID and Key
          await _db.ref('teachers/$uid').set({'key': key});
          Navigator.of(context).pop();
        }

        setState(() {
          isLoading = false;
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
          "Student and Teacher Keys",
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
                // Radio buttons to choose between Student and Teacher options
                ListTile(
                  title: const Text('Add Student UID and Key'),
                  leading: Radio<UserOption>(
                    value: UserOption.student,
                    groupValue: selectedOption,
                    onChanged: (UserOption? value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Add Teacher UID and Key'),
                  leading: Radio<UserOption>(
                    value: UserOption.teacher,
                    groupValue: selectedOption,
                    onChanged: (UserOption? value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(
                    label: Text('User Uid'),
                    icon: Icon(FontAwesomeIcons.idCard),
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
                    uid = int.tryParse(value!)!;
                  },
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(
                    label: Text('User Key'),
                    icon: Icon(FontAwesomeIcons.key),
                  ),
                  keyboardType: TextInputType.number,
                  cursorWidth: 1,
                  validator: (value) {
                    if (int.tryParse(value!) == null) {
                      return 'Must be a number';
                    }
                    if (value.trim().length != 4) {
                      return 'Must be a 4-digit number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    key = int.tryParse(value!)!;
                  },
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
                                  Theme.of(context).colorScheme.onPrimary,
                            ),
                            child: const Text("Save"),
                          ),
                    TextButton(
                      onPressed: () {
                        formKey.currentState!.reset();
                      },
                      child: const Text("Reset"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const KeysListPage()));
                  },
                  child: const Center(child: Text("Show keys")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KeysListPage extends StatefulWidget {
  const KeysListPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _KeysListPageState createState() => _KeysListPageState();
}

class _KeysListPageState extends State<KeysListPage> {
  Future<Map<String, dynamic>> fetchStudentData() async {
    final dataSnapshot = await _db.ref('students').once();
    final data = dataSnapshot.snapshot.value;
    if (data != null && data is Map<dynamic, dynamic>) {
      final Map<String, dynamic> typedData = Map<String, dynamic>.from(data);
      return typedData;
    }
    return {}; // Return an empty map if data is not a valid map
  }

  Future<Map<String, dynamic>> fetchTeacherData() async {
    final dataSnapshot = await _db.ref('teachers').once();
    final data = dataSnapshot.snapshot.value;

    if (data != null && data is Map<dynamic, dynamic>) {
      final Map<String, dynamic> typedData = Map<String, dynamic>.from(data);
      return typedData;
    }
    return {}; // Return an empty map if data is not a valid map
  }

  Future<void> deleteKey(String uid, String userType) async {
    try {
      // Remove the key from the database based on the user type (students or teachers)
      await _db.ref('$userType/$uid').remove();

      // Show a success message or perform any other actions after deletion
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Key for UID $uid has been deleted.")),
        );
      });
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting the key: ${error.message}")),
      );
    }
  }

  Widget _buildUserListTile(String uid, String userType, String userKey) {
    return ListTile(
      title: Text("UID: $uid"),
      subtitle: Text("Key: $userKey"),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 0, 0),
            foregroundColor: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Delete Key"),
              content:
                  Text("Are you sure you want to delete the key for UID $uid?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    // Call the deleteKey function here to delete the key from the database
                    deleteKey(uid, userType);
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          );
        },
        child: const Text("Delete"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "UID and Keys List",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Student List:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: fetchStudentData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final studentData = snapshot.data ?? {};

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: studentData.length,
                    itemBuilder: (context, index) {
                      final studentUid = studentData.keys.elementAt(index);
                      final studentKey = studentData[studentUid]['key'];

                      return _buildUserListTile(
                          studentUid, 'students', '$studentKey');
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Teacher List:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: fetchTeacherData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final teacherData = snapshot.data ?? {};

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: teacherData.length,
                    itemBuilder: (context, index) {
                      final teacherUid = teacherData.keys.elementAt(index);
                      final teacherKey = teacherData[teacherUid]['key'];
                      return _buildUserListTile(
                          teacherUid, 'teachers', '$teacherKey');
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
