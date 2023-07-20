import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class AttendanceTile extends StatefulWidget {
  const AttendanceTile(
      {super.key, required this.student, required this.onToggleFun});

  final Map<String, dynamic> student;
  final void Function(bool isPresent) onToggleFun;

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  bool? selected;
  @override
  void initState() {
    selected = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        widget.student['name'].toString().capitalize(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Row(
        children: [
          Text('uuid : ${widget.student['uid'].toString().capitalize()}')
        ],
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
          if (index == 0) {
            widget.onToggleFun(true);
          } else if (index == 1) {
            widget.onToggleFun(false);
          }
        },
      ),
    );
  }
}
