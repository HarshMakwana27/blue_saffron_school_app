// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/widgets/attendance_tile.dart';

class AttendanceData {
  final String uid;
  bool isPresent;

  AttendanceData({required this.uid, required this.isPresent});
}

class TakeAttendance extends StatefulWidget {
  const TakeAttendance({
    required this.selectedMedium,
    required this.selectedStandard,
    super.key,
  });

  final String selectedMedium;
  final String selectedStandard;
  @override
  State<TakeAttendance> createState() {
    return _TakeAttendanceState();
  }
}

class _TakeAttendanceState extends State<TakeAttendance> {
  List<AttendanceData> attendanceList = [];

  String formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());

  void _onSave() async {
    Map<String, dynamic> attendanceValues = {
      'date': formattedDate,
      'attendance': {},
    };

    for (var attendance in attendanceList) {
      attendanceValues['attendance'][attendance.uid] = attendance.isPresent;
    }

    // Save the attendance data to Firestore
    try {
      var docRef = FirebaseFirestore.instance
          .collection(
              'attendance_records/${widget.selectedMedium}/${widget.selectedStandard}')
          .doc(formattedDate);

      var existingDoc = await docRef.get();
      if (existingDoc.exists) {
        // Show a warning dialog with the option to override existing attendance
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Attendance Already Exists'),
              content: const Text(
                  'Attendance for this date already exists. Do you want to override it?'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Override the existing attendance data
                    docRef.set(attendanceValues).then((_) {
                      // Show a success message after successful override
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Attendance overridden successfully.'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Navigate back to the previous screen
                      Navigator.of(context).pop();
                    }).catchError((error) {
                      // Show an error message if there was an error while overriding attendance
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error overriding attendance: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  },
                  child: const Text('Override'),
                ),
                TextButton(
                  onPressed: () {
                    // Just close the dialog and return to the previous screen
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      } else {
        // Add the attendance data if it doesn't exist
        await docRef.set(attendanceValues);

        // Show a success message after successful attendance
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attendance saved successfully.'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to the previous screen
        Navigator.of(context).pop();
      }
    } on FirebaseException catch (e) {
      // Show an error message if there was an error while saving attendance
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving attendance: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersStream = FirebaseFirestore.instance
        .collection(
            'students/${widget.selectedMedium}/${widget.selectedStandard}')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Today\'s Date: ${DateFormat('dd MMMM yyyy').format(DateTime.now())}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
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

                    if (loadedMessage.isEmpty) {
                      return const Center(child: Text('No students'));
                    }

                    attendanceList = loadedMessage
                        .map((student) => AttendanceData(
                              uid: (student['uid']
                                  .toString()), // Assuming you have a field 'uid' for each student
                              isPresent: false,
                            ))
                        .toList();
                    return ListView.builder(
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
                    );
                  } catch (e) {
                    return Center(child: Text('Error: $e'));
                  }
                },
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width * 0.9)),
                onPressed: _onSave,
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
