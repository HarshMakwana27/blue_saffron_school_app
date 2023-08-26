//Creating a new updated add student form, eventually it will replace the old one

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

enum Gender { male, female, others }

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
  final TextEditingController _dobController = TextEditingController();

  int? _grNumber;
  String? _medium;
  String? _standard;

  String? _surname;
  String? _name;
  String? _fatherName;
  String? _motherName;

  String? _dob;
  String _selectedGender = "male";

  String? imageUrl;
  XFile? _pickedFile;
  //CroppedFile? _croppedFile;

  int currentStep = 0;

  bool isLoading = false;

  void _showDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2015),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
        _dob = _dobController.text;
      });
    }
  }

  Future<void> selectImageFromCamera() async {
    try {
      final selectedImage = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      if (selectedImage != null) {
        setState(() {
          _pickedFile = selectedImage;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  // Function to select an image from the gallery
  Future<void> selectImage() async {
    try {
      final selectedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (selectedImage != null) {
        setState(() {
          _pickedFile = selectedImage;
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  // Future<void> _cropImage() async {
  //   if (_pickedFile != null) {
  //     final croppedFile = await ImageCropper().cropImage(
  //       sourcePath: _pickedFile!.path,
  //       compressFormat: ImageCompressFormat.jpg,
  //       compressQuality: 100,
  //       aspectRatioPresets: [CropAspectRatioPreset.original],
  //       uiSettings: [
  //         AndroidUiSettings(
  //             toolbarTitle: 'Cropper',
  //             toolbarColor: Colors.deepOrange,
  //             toolbarWidgetColor: Colors.white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false),
  //       ],
  //     );
  //     if (croppedFile != null) {
  //       setState(() {
  //         _croppedFile = croppedFile;
  //       });
  //     }
  //   }
  // }

  Future<void> uploadImage() async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('student_images/${widget.uid}');
      await storageRef.putFile(File(_pickedFile!.path));

      imageUrl = await storageRef.getDownloadURL();
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  void saveInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseDatabase.instance
          .ref('students/${widget.uid}')
          .set({'key': widget.uidKey});

      await FirebaseFirestore.instance
          .collection('students')
          .doc('$_medium/$_standard/${widget.uid}')
          .set({
        'uid': widget.uid,
        'key': widget.uidKey,
        'surname': _surname,
        'grnumber': _grNumber,
        'name': _name,
        "father's name": _fatherName,
        "mother's name": _motherName,
        'gender': _selectedGender,
        'dob': _dob,
        'medium': _medium,
        'standard': _standard,
        'imageurl': imageUrl,
      });

      setState(() {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Successfully added student")));
        isLoading = false;
      });
      Navigator.of(context).pop();
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication Failed")));
      setState(() {
        isLoading = false;
        Navigator.of(context).pop();
      });
    }
  }

  Widget _image() {
    if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

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
            } else if (currentStep == 2) {
              if (personalFormKey.currentState!.validate()) {
                setState(() {
                  currentStep += 1;
                });
              }
            } else if (currentStep == 3) {
              if (_pickedFile == null) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select an image"),
                  ),
                );
              } else {
                uploadImage();
                setState(() {
                  currentStep += 1;
                });
              }
            } else if (isLastStep) {
              saveInfo();
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
        content: Form(
          key: basicFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Acedemic info",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
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
              Text(
                "Enter the information",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
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
        content: Form(
          key: personalFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select the Gender',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: "male",
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      const Text('Male'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "female",
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      const Text('Female'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "others",
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      const Text('Others'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Birthdate',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dobController,
                      decoration: const InputDecoration(
                        hintText: ' - Select birthdate - ',
                      ),
                      readOnly: true,
                      onTap: _showDatePicker,
                      validator: (value) {
                        if (_dob == null) {
                          return 'Please select a birthdate';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: _showDatePicker,
                    icon: const Icon(Icons.date_range),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const SizedBox(),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Student's image",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),

            _image(),

            TextButton.icon(
              label: const Text('Select from gallary'),
              onPressed: selectImage,
              icon: const Icon(CupertinoIcons.photo),
            ),
            const SizedBox(width: 20),
            TextButton.icon(
              label: const Text('Upload from camera'),
              onPressed: selectImageFromCamera,
              icon: const Icon(CupertinoIcons.photo_camera),
            ),
            // TextButton.icon(
            //   label: const Text('Crop'),
            //   onPressed: _cropImage,
            //   icon: const Icon(CupertinoIcons.crop),
            // ),
          ],
        ),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const SizedBox(),
        content: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_pickedFile != null)
                    CircleAvatar(
                      radius: 50,
                      foregroundImage: FileImage(File(_pickedFile!.path)),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("GR number: $_grNumber"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Student's name : $_name $_surname"),
                  Text("Father's name : $_fatherName"),
                  Text("Mother's name : $_motherName"),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("$_medium medium"),
                  Text("$_standard standard"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Gender: $_selectedGender"),
                  Text("Date of birth : $_dob"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("uid: ${widget.uid}"),
                  Text("key ${widget.uidKey}"),
                ],
              ),
      ),
    ];
  }
}
