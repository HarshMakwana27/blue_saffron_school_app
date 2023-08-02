// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class ValidateUid extends StatefulWidget {
  const ValidateUid({super.key});

  @override
  State<ValidateUid> createState() => _ValidateUidState();
}

class _ValidateUidState extends State<ValidateUid> {
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  bool _isValid = false;
  int? uid;
  int? key;
  void validate() async {
    if (_FormKey.currentState!.validate()) {
      try {
        // Check if the UID already exists
        final snapshot = await FirebaseDatabase.instance
            .ref('students/')
            .equalTo(uid.toString())
            .get();
        print(snapshot.value);
        if (snapshot.value == null) {
          // UID already exists, show SnackBar

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('UID already exists. Please enter a different UID.')),
          );
          setState(() {
            _isValid = false;
          });
        } else {
          // UID does not exist, set it in the database
          print('Yeas it is uniuyq');

          setState(() {
            _isValid = true;
          });
        }
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? "Authentication Failed")));
        setState(() {
          _isValid = false;
        });
      }
    }
  }

  void saveKey() {}
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _FormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a unique ID for student',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: _isValid,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Unique id',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty ||
                        int.tryParse(value.trim()) == null ||
                        value.trim().length != 4) {
                      return 'Please Enter valid UID';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    uid = int.parse(value!.trim());
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Note : ',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                ),
                const Text(
                  "It has to be 4 digits\nFor convinience please folow this format 50XX",
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isValid)
                  Text(
                    'Create a UID key',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                if (_isValid)
                  const SizedBox(
                    height: 10,
                  ),
                if (_isValid)
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'UID key',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value.trim().length < 4) {
                        return 'Please enter a strong key';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      key = int.parse(value!.trim());
                    },
                  ),
                if (_isValid)
                  const SizedBox(
                    height: 20,
                  ),
                if (_isValid)
                  const Text(
                    "It will be used for signning in process of parent",
                  ),
                if (_isValid)
                  const SizedBox(
                    height: 50,
                  ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_isValid) {
                        validate();
                      } else {
                        saveKey();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(width * 0.95)),
                    child: Text(_isValid ? 'Next' : 'Validate'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
