import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
        onTap: () {},
        title: Text(
          student['name'].toString().capitalize(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Row(
          children: [Text('uuid : ${student['uid'].toString().capitalize()}')],
        ),
        trailing: ToggleSwitch(
          fontSize: 10,
          minWidth: 70,
          initialLabelIndex: 1,
          minHeight: 35,
          cornerRadius: 7,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          labels: const [
            'Preset',
            'Absent',
          ],
          activeBgColors: const [
            [Colors.lightGreen],
            [Colors.red]
          ],
          onToggle: (index) {
            if (index == 0) {}
            if (index == 1) {}
          },
        ));
  }
}
