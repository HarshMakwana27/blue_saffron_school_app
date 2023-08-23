//Creating a new updated add student form, eventually it will replace the old one

import 'package:flutter/material.dart';

class AddNewStudent extends StatefulWidget {
  const AddNewStudent({super.key, required this.uid, required this.uidKey});

  final String uid;
  final int uidKey;
  @override
  State<AddNewStudent> createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  final basicFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  final personalFormKey = GlobalKey<FormState>();

  int? _grNumber;
  String? _medium;
  String? _standard;

  String? _surname;
  String? _name;
  String? _fatherName;
  String? _motherName;

  String? _dob;
  String? _gender;

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

            if (currentStep == 0) {
              if (basicFormKey.currentState!.validate()) {
                basicFormKey.currentState!.save();
                setState(() {
                  currentStep += 1;
                });
              }
            } else if (currentStep == 1) {
              if (nameFormKey.currentState!.validate()) {
                nameFormKey.currentState!.save();
                setState(() {
                  currentStep += 1;
                });
              }
            }

            if (isLastStep) {
              //Do something with this information
            } else {}
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
        content: Form(
          key: basicFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Acedemic info"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: 'GR Number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _grNumber = int.parse(value!);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Medium',
                    labelText: 'Select the medium of student'),
                items: const [
                  DropdownMenuItem(
                    value: 'english',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'gujarati',
                    child: Text('gujarati'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Please select medium';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _medium = value!;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    _medium = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: _standard,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Standard',
                    labelText: 'Select the Standard of student'),
                items: const [
                  DropdownMenuItem(
                    value: 'nursery',
                    child: Text('Nursery'),
                  ),
                  DropdownMenuItem(
                    value: 'kg1',
                    child: Text('kg1'),
                  ),
                  DropdownMenuItem(
                    value: 'kg2',
                    child: Text('kg2'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Please select standard';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _standard = value!;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _standard = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const SizedBox(),
        content: Form(
          key: nameFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter the information"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: 'Surname of student',
                ),
                validator: (value) {
                  if (value == null || value.trim().length <= 1) {
                    return 'Enter a valid surname';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _surname = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: 'First name',
                ),
                validator: (value) {
                  if (value == null || value.trim().length <= 1) {
                    return 'Enter a valid name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _name = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: "Father's name",
                ),
                validator: (value) {
                  if (value == null || value.trim().length <= 1) {
                    return 'Enter a valid name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _fatherName = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: "Mother's name",
                ),
                validator: (value) {
                  if (value == null || value.trim().length <= 1) {
                    return 'Enter a valid name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _motherName = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const SizedBox(),
          content: Column(
            children: [],
          )),
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
