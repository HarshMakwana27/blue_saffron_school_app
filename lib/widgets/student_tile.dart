import 'package:flutter/material.dart';
import 'package:school/model/student.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class StudentTile extends StatelessWidget {
  const StudentTile(this.student, {super.key});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {},
        leading: Text(
          student.rollNumber.toString(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        title: Text(
          student.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Row(
          children: [Text('${student.medium.name.capitalize()} Medium')],
        ),
        trailing: const Icon(
          Icons.abc,
          size: 40,
        ),
        tileColor: student.gender.name == 'male'
            ? Colors.blue.withOpacity(0.1)
            : Colors.pink.withOpacity(0.1));
  }
}
