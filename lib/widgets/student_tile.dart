import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/screens/inHomeScreen/student_info.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class StudentTile extends StatelessWidget {
  const StudentTile(this.student, {super.key});

  final Map<String, dynamic> student;

  void _deleteStudent(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this document?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _performDelete(); // Call the actual delete operation
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _performDelete() async {
    try {
      String imageUrl = student['imageurl'];

      await FirebaseStorage.instance.refFromURL(imageUrl).delete();

      final DocumentReference documentRef = FirebaseFirestore.instance
          .collection('students')
          .doc('${student['medium']}/${student['standard']}/${student['uid']}');
      await documentRef.delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        _deleteStudent(context);
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StudentInfo(
                  studentData: student,
                )));
      },
      leading: Image.network(student['imageurl']),
      title: Text(
        student['name'].toString().capitalize(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Row(
        children: [Text('Uid : ${student['uid'].toString().capitalize()}')],
      ),
      trailing: const Icon(
        CupertinoIcons.arrow_right,
        size: 20,
      ),
    );
  }
}
