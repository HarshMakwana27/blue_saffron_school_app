// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:school/main.dart';
import 'package:school/screens/auth/choose.dart';

import 'package:school/screens/inHomeScreen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  bool _isLoading = false;

  String _email = '';
  String _password = '';

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

  void _forgetPassword() async => showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'A Link to reset your password will be sent to your registered email address',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter your registered email",
                    icon: Icon(
                      Icons.account_box_rounded,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey2.currentState!.validate()) {
                          _formKey2.currentState!.save();
                          Navigator.of(context).pop(); // Close the bottom sheet

                          try {
                            await kfirebaseauth.sendPasswordResetEmail(
                                email: _email);

                            ScaffoldMessenger.of(context).clearSnackBars();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Password reset email sent successfully!'),
                                duration: Duration(
                                    seconds:
                                        3), // You can set the duration for which the SnackBar is visible.
                              ),
                            );
                          } on FirebaseAuthException catch (error) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  error.toString(),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.send_rounded),
                      label: const Text('Send'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });

  void _onSave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        setState(() {
          _isLoading = true;
        });

        await kfirebaseauth.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
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
              'Log In',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome Back !',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: _forgetPassword,
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          )),
                    ],
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
                          onPressed: _onSave,
                          child: const Text('Log in'),
                        ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const ChooseCategory()));
                      },
                      child: const Text('Create an Account')),
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
