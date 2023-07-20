import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _db = FirebaseDatabase.instance;

class StudentKey extends StatefulWidget {
  const StudentKey({super.key});

  @override
  State<StudentKey> createState() => _StudentKeyState();
}

class _StudentKeyState extends State<StudentKey> {
  final formKey = GlobalKey<FormState>();

  int? uid;
  int? studentKey;

  bool isLoading = false;

  void isSuccessFun() {
    showDialog(
      context: context,
      barrierLabel: 'okay',
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const Icon(
                Icons.check,
                color: Colors.green,
                size: 70,
              ),
              Text("Success",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.green)),
              const SizedBox(
                height: 10,
              ),
              const Text("'Student added to the list'"),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void isNotSuccessFun() {
    showDialog(
      context: context,
      barrierLabel: 'okay',
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const Icon(
                Icons.close,
                color: Colors.red,
                size: 70,
              ),
              Text("Failed",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.red)),
              const SizedBox(
                height: 10,
              ),
              const Text("Fail to add student"),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveInfo() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });

      try {
        await _db.ref('students/$uid').set({'key': studentKey});
        setState(() {
          isLoading = false;
          isSuccessFun();
        });
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? "Authentication Failed")));
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Keys",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(
                      label: Text('Student Uid'),
                      icon: Icon(FontAwesomeIcons.idCard)),
                  keyboardType: TextInputType.number,
                  cursorWidth: 1,
                  validator: (value) {
                    if (int.tryParse(value!) == null) {
                      return 'Must be a number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    uid = int.tryParse(value!)!;
                  },
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(
                      label: Text('Key'), icon: Icon(FontAwesomeIcons.key)),
                  keyboardType: TextInputType.number,
                  cursorWidth: 1,
                  validator: (value) {
                    if (int.tryParse(value!) == null) {
                      return 'Must be a number';
                    }
                    if (value.trim().length != 4) {
                      return 'Must be a 4 digit number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    studentKey = int.tryParse(value!)!;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: saveInfo,
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary),
                            child: const Text("save"),
                          ),
                    TextButton(
                        onPressed: () {
                          formKey.currentState!.reset();
                        },
                        child: const Text("Reset")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
