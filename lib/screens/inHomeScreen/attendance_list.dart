import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:school/screens/inHomeScreen/student_attendance.dart';
import 'package:school/widgets/attendance_tile.dart';

class Attendancelist extends StatefulWidget {
  const Attendancelist({super.key});

  @override
  State<Attendancelist> createState() {
    return _AttendancelistState();
  }
}

class _AttendancelistState extends State<Attendancelist> {
  String _selectedMedium = 'english';
  String _selectedStandard = 'kg1';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Medium and Standard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Selected Month',
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(
                  DateFormat('MMMM yyyy').format(_selectedDate),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.green,
            height: 0.5,
            width: 150,
          ),
          SizedBox(
            width: 150,
            child: DropdownButton<String>(
              isExpanded: true,
              alignment: Alignment.center,
              value: _selectedMedium,
              hint: const Text('Select Medium'),
              onChanged: (newValue) {
                setState(() {
                  _selectedMedium = newValue!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'english',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'gujarati',
                  child: Text('Gujarati'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 150,
            child: DropdownButton<String>(
              isExpanded: true,
              alignment: Alignment.center,
              value: _selectedStandard,
              hint: const Text('Select Standard'),
              onChanged: (newValue) {
                setState(() {
                  _selectedStandard = newValue!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'kg1',
                  child: Text('KG1'),
                ),
                DropdownMenuItem(
                  value: 'kg2',
                  child: Text('KG2'),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedMedium.isNotEmpty && _selectedStandard.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceListScreen(
                      selectedDate: _selectedDate,
                      selectedMedium: _selectedMedium,
                      selectedStandard: _selectedStandard,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select Medium and Standard.'),
                  ),
                );
              }
            },
            child: const Text('Proceed'),
          ),
        ],
      ),
    );
  }
}

class AttendanceListScreen extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedMedium;
  final String selectedStandard;

  const AttendanceListScreen(
      {required this.selectedDate,
      required this.selectedMedium,
      required this.selectedStandard,
      super.key});

  @override
  State<AttendanceListScreen> createState() {
    return _AttendanceListScreenState();
  }
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  List<StudentPresentDays> studentPresentDaysList = [];

  Future<List<StudentPresentDays>> fetchAttendanceData() async {
    // Implement fetching the attendance data for the selected month from Firestore
    // and calculate the attendance for each student from the 1st day to the last day.
    // Update the attendanceList with the fetched data.
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection(
              'attendance_records/${widget.selectedMedium}/${widget.selectedStandard}')
          .where('date', isGreaterThanOrEqualTo: firstDayOfMonth())
          .where('date', isLessThanOrEqualTo: lastDayOfMonth())
          .get();

      // Clear the existing studentPresentDaysList
      studentPresentDaysList.clear();

      // Create a map to store the count of days present for each student
      Map<String, int> studentDaysPresentCount = {};

      // Iterate through the querySnapshot and update studentDaysPresentCount
      for (var document in querySnapshot.docs) {
        var attendanceData = document.data();
        attendanceData['attendance'].forEach((uid, isPresent) {
          if (isPresent) {
            studentDaysPresentCount[uid] =
                (studentDaysPresentCount[uid] ?? 0) + 1;
          }
        });
      }

      // Convert the map to a list of StudentPresentDays objects
      studentPresentDaysList = studentDaysPresentCount.entries
          .map((entry) =>
              StudentPresentDays(uid: entry.key, presentDays: entry.value))
          .toList();

      // Set the state to update the UI with the fetched data
    } catch (e) {
      Center(
        child: Text(e.toString()),
      );
    }
    return studentPresentDaysList;
  }

  String firstDayOfMonth() {
    var year = DateFormat('yyyy').format(widget.selectedDate);
    var month = DateFormat('MM').format(widget.selectedDate);
    return '$year${month}01';
  }

  String lastDayOfMonth() {
    var year = DateFormat('yyyy').format(widget.selectedDate);
    var month = DateFormat('MM').format(widget.selectedDate);
    return '$year${month}31';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance List'),
      ),
      body: FutureBuilder(
        future: fetchAttendanceData(),
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.selectedMedium.capitalize(),
                            ),
                            const Icon(Icons.arrow_right),
                            Text(
                              widget.selectedStandard.capitalize(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Number of days present in',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          DateFormat('MMMM yyyy').format(widget.selectedDate),
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: studentPresentDaysList.length,
                      itemBuilder: (context, index) {
                        final studentPresentDays =
                            studentPresentDaysList[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    StudentAttendanceListScreen(
                                  studentUID: studentPresentDays.uid,
                                  selectedMedium: widget.selectedMedium,
                                  selectedStandard: widget.selectedStandard,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            'Student UID: ${studentPresentDays.uid}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            'Days Present: ${studentPresentDays.presentDays}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class StudentPresentDays {
  StudentPresentDays({required this.uid, required this.presentDays});
  final String uid;
  final int presentDays;
}
