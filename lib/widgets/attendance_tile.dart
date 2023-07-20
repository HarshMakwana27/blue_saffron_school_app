import 'package:flutter/material.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class AttendanceTile extends StatelessWidget {
  const AttendanceTile(this.student, {super.key});

  final Map<String, dynamic> student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundColor: student['gender'] == 'male'
            ? Colors.blue.withOpacity(0.1)
            : Colors.pink.withOpacity(0.1),
      ),
      title: Text(
        student['name'].toString().capitalize(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Row(
        children: [Text('uuid : ${student['uid'].toString().capitalize()}')],
      ),
      trailing: const Icon(
        Icons.abc,
        size: 40,
      ),
    );
  }
}
