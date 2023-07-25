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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const StudentInfo()));
      },
      leading: CircleAvatar(
        backgroundColor:
            student['gender'] == 'male' ? Colors.lightBlue : Colors.pinkAccent,
      ),
      title: Text(
        student['name'].toString().capitalize(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Row(
        children: [Text('Uid : ${student['uid'].toString().capitalize()}')],
      ),
      trailing: const Icon(
        Icons.abc,
        size: 40,
      ),
    );
  }
}
