import 'package:flutter/material.dart';

import 'package:school/screens/inHomeScreen/students_list.dart';
import 'package:school/screens/inHomeScreen/takeattendance.dart';

String medium = 'english';
String standard = 'kg1';

class StepperCode extends StatefulWidget {
  const StepperCode(this.pageIndex, {super.key});

  final int pageIndex;

  @override
  State<StepperCode> createState() => _StepperCodeState();
}

class _StepperCodeState extends State<StepperCode> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.pageIndex == 0 ? 'Take Attendance' : 'Students List'),
      ),
      body: Stepper(
          currentStep: _index,
          onStepContinue: () {
            if (_index < 1) {
              setState(() {
                _index += 1;
              });
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => widget.pageIndex == 0
                      ? const TakeAttendance()
                      : const StudentList(),
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
