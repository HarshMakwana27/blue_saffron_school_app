// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final kdbref = FirebaseDatabase.instance;

class KeysListPage extends StatefulWidget {
  const KeysListPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _KeysListPageState createState() => _KeysListPageState();
}

class _KeysListPageState extends State<KeysListPage> {
  Future<Map<String, dynamic>> fetchStudentData() async {
    final dataSnapshot = await kdbref.ref('students').once();
    final data = dataSnapshot.snapshot.value;
    if (data != null && data is Map<dynamic, dynamic>) {
      final Map<String, dynamic> typedData = Map<String, dynamic>.from(data);
      return typedData;
    }
    return {}; // Return an empty map if data is not a valid map
  }

  Future<Map<String, dynamic>> fetchTeacherData() async {
    final dataSnapshot = await kdbref.ref('teachers').once();
    final data = dataSnapshot.snapshot.value;

    if (data != null && data is Map<dynamic, dynamic>) {
      final Map<String, dynamic> typedData = Map<String, dynamic>.from(data);
      return typedData;
    }
    return {}; // Return an empty map if data is not a valid map
  }

  // Future<void> deleteKey(String uid, String userType) async {
  //   try {
  //     // Remove the key from the database based on the user type (students or teachers)
  //     await kdbref.ref('$userType/$uid').remove();

  //     // Show a success message or perform any other actions after deletion
  //     setState(() {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Key for UID $uid has been deleted.")),
  //       );
  //     });
  //   } on FirebaseException catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error deleting the key: ${error.message}")),
  //     );
  //   }
  // }

  Widget _buildUserListTile(String uid, String userType, String userKey) {
    return ListTile(
      title: Text("UID: $uid"),
      trailing: Text("Key: $userKey"),
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
