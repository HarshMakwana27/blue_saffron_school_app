import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school/widgets/attendance_tile.dart';
import 'package:school/screens/stepper.dart';

class AttendanceData {
  final String uid;
  bool isPresent;

  AttendanceData({required this.uid, required this.isPresent});
}

class TakeAttendance extends StatefulWidget {
  const TakeAttendance({
    super.key,
  });

  @override
  State<TakeAttendance> createState() {
    return _TakeAttendanceState();
  }
}

class _TakeAttendanceState extends State<TakeAttendance> {
  List<AttendanceData> attendanceList = [];
  DateTime currentDate = DateTime.now();

  void _onSave() async {
    String formattedDate = currentDate.toLocal().toString();
    Map<String, dynamic> attendanceValues = {
      'date': formattedDate,
      'attendance': {},
    };

    for (var attendance in attendanceList) {
      attendanceValues['attendance'][attendance.uid] = attendance.isPresent;
    }

    // Save the attendance data to Firestore
    try {
      await FirebaseFirestore.instance
          .collection('attendance_records')
          .add(attendanceValues);

      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      Center(child: Text('$e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersStream = FirebaseFirestore.instance
        .collection('students/$medium/$standard')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take Attendance"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: usersStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          try {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var loadedMessage =
                snapshot.data?.docs ?? []; // Safely handle null value

            attendanceList = loadedMessage
                .map((student) => AttendanceData(
                      uid: (student['uid']
                          .toString()), // Assuming you have a field 'uid' for each student
                      isPresent: false,
                    ))
                .toList();
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: loadedMessage.length,
                  itemBuilder: (ctx, index) {
                    // Check if the index is valid
                    if (index >= 0 && index < loadedMessage.length) {
                      final student = loadedMessage[index].data();
                      return AttendanceTile(
                        student: student,
                        onToggleFun: (
                          isPresentval,
                        ) {
                          attendanceList[index].isPresent = isPresentval;
                        },
                      );
                    } else {
                      return const Text("Invalid index");
                    }
                  },
                ),
                ElevatedButton(onPressed: _onSave, child: const Text('Save'))
              ],
            );
          } catch (e) {
            return Center(child: Text('Error: $e'));
          }
        },
      ),
    );
  }
}
