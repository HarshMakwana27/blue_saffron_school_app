import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class AttendanceList extends StatelessWidget {
  AttendanceList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance List"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400, // Adjust the height as needed
            child: SfCalendar(
              view: CalendarView.month, // Month view
              initialSelectedDate:
                  DateTime.now(), // Show today's date as selected
              onTap: (CalendarTapDetails details) {
                // Handle date selection
                if (details.targetElement == CalendarElement.calendarCell) {
                  DateTime selectedDate = details.date!;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseMediumAndStandardScreen(
                          selectedDate: selectedDate),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseMediumAndStandardScreen extends StatefulWidget {
  final DateTime selectedDate;

  ChooseMediumAndStandardScreen({required this.selectedDate});

  @override
  State<ChooseMediumAndStandardScreen> createState() {
    return _ChooseMediumAndStandardScreenState();
  }
}

class _ChooseMediumAndStandardScreenState
    extends State<ChooseMediumAndStandardScreen> {
  String _selectedMedium = 'english';
  String _selectedStandard = 'kg1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Medium and Standard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selected Date: ${DateFormat('yyyyMMdd').format(widget.selectedDate)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
                value: _selectedMedium,
                hint: Text('Select Medium'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedMedium = newValue!;
                  });
                },
                // Populate the dropdown items with the available mediums
                items: const [
                  DropdownMenuItem(
                    value: 'english',
                    child: Text('english'),
                  ),
                  DropdownMenuItem(
                    value: 'gujarati',
                    child: Text('gujarati'),
                  ),
                ]),
            DropdownButton<String>(
                value: _selectedStandard,
                hint: Text('Select Standard'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedStandard = newValue!;
                  });
                },
                // Populate the dropdown items with the available standards
                items: const [
                  DropdownMenuItem(
                    value: 'kg1',
                    child: Text('kg1'),
                  ),
                  DropdownMenuItem(
                    value: 'kg2',
                    child: Text('kg2'),
                  ),
                ] // Replace with your actual standards

                ),
            ElevatedButton(
              onPressed: () {
                if (_selectedMedium.isNotEmpty &&
                    _selectedStandard.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceListScreen(
                        selectedDate: widget.selectedDate,
                      ),
                    ),
                  );
                } else {
                  // Show an error message if medium and standard are not selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select Medium and Standard.'),
                    ),
                  );
                }
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceData {
  final String uid;
  bool isPresent;

  AttendanceData({required this.uid, required this.isPresent});
}

class AttendanceListScreen extends StatefulWidget {
  final DateTime selectedDate;

  AttendanceListScreen({super.key, required this.selectedDate});

  @override
  _AttendanceListScreenState createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  List<AttendanceData> attendanceList = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  void fetchAttendanceData() async {
    // Implement fetching the attendance data for the selected month from Firestore
    // and calculate the attendance for each student from the 1st day to the last day.
    // Update the attendanceList with the fetched data.
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('attendance_records')
          .get();

      print(querySnapshot.docs);

      // Clear the existing attendanceList
      attendanceList.clear();

      // Iterate through the querySnapshot and update attendanceList
      for (var document in querySnapshot.docs) {
        var attendanceData = document.data();
        attendanceData['attendance'].forEach((uid, isPresent) {
          attendanceList.add(AttendanceData(uid: uid, isPresent: isPresent));
          print(attendanceList);
        });
      }

      // Set the state to update the UI with the fetched data
      setState(() {});
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
  }

  DateTime firstDayOfMonth() {
    var year = int.parse(widget.selectedDate.toString().substring(0, 4));
    var month = int.parse(widget.selectedDate.toString().substring(4, 6));
    return DateTime(year, month, 1);
  }

  DateTime lastDayOfMonth() {
    var year = int.parse(widget.selectedDate.toString().substring(0, 4));
    var month = int.parse(widget.selectedDate.toString().substring(4, 6));
    var lastDay = DateTime(year, month + 1, 0);
    return DateTime(lastDay.year, lastDay.month, lastDay.day);
  }

  int calculateDaysPresent(String uid) {
    return attendanceList
        .where((data) => data.uid == uid && data.isPresent)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Attendance for ${DateFormat('MMMM yyyy').format(widget.selectedDate)}'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: attendanceList.length,
          itemBuilder: (context, index) {
            final attendanceData = attendanceList[index];
            return ListTile(
              title: Text('Student UID: ${attendanceData.uid}'),
              subtitle: Text(
                  'Days Present: ${calculateDaysPresent(attendanceData.uid)}'),
            );
          },
        ),
      ),
    );
  }
}
