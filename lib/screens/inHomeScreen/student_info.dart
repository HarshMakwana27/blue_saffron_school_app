// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school/widgets/attendance_tile.dart';

class StudentInfo extends StatelessWidget {
  final Map<String, dynamic> studentData;
  const StudentInfo({
    required this.studentData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        alignment: const Alignment(0, -1),
        children: [
          Column(
            children: [
              Container(
                height: height * 0.2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          Container(
            height: height * 0.33,
            width: width * 0.9,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                //  color: Colors.amber,
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.065),
              child: Container(
                // width: width * 0.9,
                // height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.086,
                    ),
                    Text(
                      studentData['name'].toString().capitalize(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      studentData['standard'],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      color: Colors.black,
                      height: 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${studentData['uid']}',
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.black,
                          width: .1,
                          height: 40,
                        ),
                        Text(
                          '${studentData['medium'].toString().capitalize()} \n Medium',
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.black,
                          width: 0.1,
                          height: 40,
                        ),
                        Text(studentData['gender'].toString().capitalize())
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            foregroundImage: studentData['gender'] == 'male'
                ? const AssetImage('assets/images/profile.png')
                : const AssetImage('assets/images/profilegirl.png'),
          ),
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
    );
  }
}

class MedStdforInfo extends StatefulWidget {
  const MedStdforInfo({super.key, required this.uid});

  final int uid;

  @override
  State<MedStdforInfo> createState() => _MedStdforInfoState();
}

class _MedStdforInfoState extends State<MedStdforInfo> {
  String selectedMedium = 'english';
  String selectedStandard = 'kg1';

  Future<void> searchStudentData(int uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> studentDoc = await FirebaseFirestore
          .instance
          .collection('students')
          .doc(
              selectedMedium) // Assuming selectedMedium is either 'english' or 'gujarati'
          .collection(
              selectedStandard) // Assuming selectedStandard is either 'kg1' or 'kg2'
          .doc(uid.toString())
          .get();

      if (studentDoc.exists) {
        // Student data found, navigate to StudentInfo page with the data
        final Map<String, dynamic> studentData = studentDoc.data()!;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentInfo(studentData: studentData),
          ),
        );
      } else {
        // Student data not found, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sorry, student data doesn't exist."),
          ),
        );
      }
    } catch (e) {
      // Error occurred while searching for data
      print('Error searching for student data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student card'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Please Select your child's \nMedium and Standard",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Select medium:'),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 130,
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.center,
                  value: selectedMedium,
                  hint: const Text('Select Medium'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedMedium = newValue!;
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Select Standard:'),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 130,
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.center,
                  value: selectedStandard,
                  hint: const Text('Select Standard'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedStandard = newValue!;
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
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              searchStudentData(widget.uid);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(width * 0.8)),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
