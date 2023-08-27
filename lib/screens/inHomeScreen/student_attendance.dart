import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentAttendanceListScreen extends StatelessWidget {
  final String studentUID;
  final String selectedMedium;
  final String selectedStandard;

  const StudentAttendanceListScreen({
    required this.studentUID,
    required this.selectedMedium,
    required this.selectedStandard,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance'),
      ),
      body: Column(
        children: [
          Text(
            'uid $studentUID',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Text(
                  'Date',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text(
                  '',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: fetchStudentAttendanceData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No data'),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final attendanceData = snapshot.data![index];
                    final date = DateFormat('dd/MM/yyyy').format(DateTime(
                      int.parse(
                          attendanceData['date'].toString().substring(0, 4)),
                      int.parse(
                          attendanceData['date'].toString().substring(4, 6)),
                      int.parse(
                        attendanceData['date'].toString().substring(6),
                      ),
                    ));
                    if (attendanceData['attendance'][studentUID] == null) {
                      return const Center(child: SizedBox());
                    }
                    return ListTile(
                      title: Text(date),
                      trailing: Text(
                        attendanceData['attendance'][studentUID]
                            ? 'Present'
                            : 'Absent',
                        style: TextStyle(
                            color: attendanceData['attendance'][studentUID]
                                ? Colors.green
                                : Colors.red),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchStudentAttendanceData() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('attendance_records/$selectedMedium/$selectedStandard')
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching student attendance data: $e');
      return [];
    }
  }
}
