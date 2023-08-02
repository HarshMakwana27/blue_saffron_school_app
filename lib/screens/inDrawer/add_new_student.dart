//Creating a new updated add student form, eventually it will replace the old one

import 'package:flutter/material.dart';

class AddNewStudent extends StatefulWidget {
  const AddNewStudent({super.key});

  @override
  State<AddNewStudent> createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new student'),
        ),
        body: Stepper(
          elevation: 0.5,
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepCancel: () => currentStep == 0
              ? null
              : setState(() {
                  currentStep -= 1;
                }),
          onStepContinue: () {
            bool isLastStep = (currentStep == steps().length - 1);

            if (isLastStep) {
              //Do something with this information
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          // onStepTapped: (step) => setState(() {
          //   currentStep = step;
          // }),
          steps: steps(),
        ));
  }

  List<Step> steps() {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const SizedBox(),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Student's details"),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                labelText: 'Surname of student',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                labelText: 'First name',
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  throw 'value is empty';
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                labelText: 'Last name',
              ),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const SizedBox(),
        content: const Text('Content of step 2'),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const SizedBox(),
        content: Text('Content of step 3'),
      ),
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const SizedBox(),
        content: Text('Content of step 4'),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const SizedBox(),
        content: const Text('Content of step 1'),
      ),
    ];
  }
}
