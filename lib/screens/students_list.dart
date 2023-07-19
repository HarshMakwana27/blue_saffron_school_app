import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String medium = 'english';
String standard = 'kg1';

class StudentList extends StatefulWidget {
  const StudentList({
    super.key,
  });

  @override
  State<StudentList> createState() {
    return _StudentListState();
  }
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    final usersStream = FirebaseFirestore.instance
        .collection('students/$medium/$standard')
        .snapshots();
    return Scaffold(
      appBar: AppBar(),
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

            final loadedMessage =
                snapshot.data?.docs ?? []; // Safely handle null value

            return ListView.builder(
              itemCount: loadedMessage.length,
              itemBuilder: (ctx, index) {
                // Check if the index is valid
                if (index >= 0 && index < loadedMessage.length) {
                  final name = loadedMessage[index].data()['name'];
                  return Text(name);
                } else {
                  return const Text("Invalid index");
                }
              },
            );
          } catch (e) {
            return Text('Error: $e');
          }
        },
      ),
    );
  }
}

class StepperCode extends StatefulWidget {
  const StepperCode({super.key});

  @override
  State<StepperCode> createState() => _StepperCodeState();
}

class _StepperCodeState extends State<StepperCode> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students List'),
      ),
      body: Stepper(
          stepIconBuilder: (stepIndex, stepState) {
            return CircleAvatar(
              child: Icon(stepIndex == 0 ? Icons.abc : Icons.ac_unit_outlined),
            );
          },
          currentStep: _index,
          onStepContinue: () {
            if (_index < 1) {
              setState(() {
                _index += 1;
              });
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const StudentList(),
                ),
              );
            }
          },
          onStepCancel: () {
            if (_index >= 1) {
              setState(() {
                _index -= 1;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
          onStepTapped: (int index) {
            setState(() {
              _index = index;
            });
          },
          steps: [
            Step(
              title: const Text('Select a Medium'),
              content: Row(
                children: [
                  DropdownButton(
                    underline: Container(
                      color: Theme.of(context).colorScheme.primary,
                      height: 1.5,
                    ),
                    value: medium,
                    items: const [
                      DropdownMenuItem(
                        value: 'english',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'gujarati',
                        child: Text('Gujarati'),
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        medium = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Select a Standard'),
              content: Row(
                children: [
                  DropdownButton(
                    underline: Container(
                      color: Theme.of(context).colorScheme.primary,
                      height: 1.5,
                    ),
                    value: standard,
                    items: const [
                      DropdownMenuItem(
                        value: 'kg1',
                        child: Text('kg1'),
                      ),
                      DropdownMenuItem(
                        value: 'kg2',
                        child: Text('kg2'),
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        standard = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
