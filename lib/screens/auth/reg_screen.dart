import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:school/main.dart';

import 'package:school/screens/auth/login_screen.dart';
import 'package:school/screens/inHomeScreen/home_screen.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key, required this.isStudent});
  final bool isStudent;

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isVerified = false;

  bool _isLoading = false;
  String number = '';
  String _email = '';
  String _password = '';

  String _name = '';
  int? _uid;
  int? _key;

  Future<bool> validateUidAndKey(int uid, int key, bool isStudent) async {
    final userType = isStudent ? 'students' : 'teachers';

    try {
      // Fetch the user data from the database based on the entered UID
      final dataSnapshot = await kdbref.ref('$userType/$uid').once();
      final userData = dataSnapshot.snapshot.value;

      if (userData != null && userData is Map<dynamic, dynamic>) {
        final Map<String, dynamic> typedData =
            Map<String, dynamic>.from(userData);

        if (typedData['key'] == key) {
          // The UID and key match, allow registration
          return true;
        } else {
          // The UID and key do not match, display an error message
          setState(() {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text("Invalid UID or Key. Please check and try again.")),
            );
          });

          return false;
        }
      } else {
        // The UID and key do not match, display an error message
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text("Invalid UID or Key. Please check and try again.")),
          );
        });

        return false;
      }
    } catch (error) {
      // Handle any errors that occur during the data fetching process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching user data: $error")),
      );
      return false;
    }
  }

  void _onVerify() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });

        final isUidAndKeyValid =
            await validateUidAndKey(_uid!, _key!, widget.isStudent);

        if (isUidAndKeyValid) {
          setState(() {
            _isVerified = true;
          });
        }
        setState(() {
          _isLoading = false;
        });
        _formKey.currentState!.reset();
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? "Authentication Failed")));
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onSave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        setState(() {
          _isLoading = true;
        });

        // Proceed with user registration
        final userCredentials = await kfirebaseauth
            .createUserWithEmailAndPassword(email: _email, password: _password);

        if (widget.isStudent) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredentials.user!.uid)
              .set({
            'name': _name,
            'email': _email,
            'uid': _uid,
            'isStudent': true,
            'number': number,
          });
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredentials.user!.uid)
              .set({
            'name': _name,
            'email': _email,
            'uid': _uid,
            'isStudent': false,
            'number': number,
          });
        }
        setState(() {
          _isLoading = false;
        });

        if (context.mounted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? "Authentication Failed")));
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset('assets/images/teacher.png'),
            ),
            Text(
              !_isVerified ? 'Signup' : 'Success',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              !_isVerified ? 'Please Verify first' : 'Account verified',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  if (_isVerified)
                    TextFormField(
                      // style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        label: Text("Email address"),
                        icon: Icon(
                          Icons.account_box_rounded,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains("@")) {
                          return "Please Enter a valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                  if (_isVerified)
                    TextFormField(
                      //style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(
                          Icons.key,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 6) {
                          return "Password should 6 characters long";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                  if (_isVerified)
                    TextFormField(
                      // style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),

                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return "Name should be 4 letters long";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                  if (!_isVerified)
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                          label: Text('Uid'), icon: Icon(Icons.card_giftcard)),
                      keyboardType: TextInputType.number,
                      cursorWidth: 1,
                      validator: (value) {
                        if (int.tryParse(value!) == null) {
                          return 'Must be a number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _uid = int.tryParse(value!)!;
                      },
                    ),
                  if (!_isVerified)
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                          label: Text(
                              widget.isStudent ? 'Student Key' : 'Teacher Key'),
                          icon: const Icon(Icons.key)),
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
                        _key = int.tryParse(value!)!;
                      },
                    ),
                  if (_isVerified)
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                          label: Text('phone number'),
                          icon: Icon(Icons.card_giftcard)),
                      keyboardType: TextInputType.number,
                      cursorWidth: 1,
                      validator: (value) {
                        if (int.tryParse(value!) == null) {
                          return 'Must be a number';
                        }
                        if (value.trim().length != 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        number = value!;
                      },
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 0.9, 6),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.background),
                          onPressed: _isVerified ? _onSave : _onVerify,
                          child:
                              Text(_isVerified ? 'Create Account' : 'Verify'),
                        ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => const LoginScreen()));
                      },
                      child: const Text('Already have an account')),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
