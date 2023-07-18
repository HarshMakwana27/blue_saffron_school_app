import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebaseAuth = FirebaseAuth.instance;

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool _isLogin = true;

  bool _isLoading = false;

  String _email = '';
  String _password = '';
  String _name = '';

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

                          try {
                            final status = await _firebaseAuth
                                .sendPasswordResetEmail(email: _email);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context)
                                .pop(); // Close the bottom sheet
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).clearSnackBars();
                            // ignore: use_build_context_synchronously
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

        if (_isLogin) {
          await _firebaseAuth.signInWithEmailAndPassword(
              email: _email, password: _password);
        } else {
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _email, password: _password);
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
              _isLogin ? 'Log In' : 'Sign Up',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              _isLogin ? 'Welcome Back !' : 'Welcome !',
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
                  if (!_isLogin)
                    TextFormField(
                      // style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return "Username should be 4 letters long";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(300, 6),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.background),
                          onPressed: _onSave,
                          child:
                              Text(_isLogin ? 'Log in' : 'Create an Account '),
                        ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                          _isLogin ? 'Create an Account' : 'Log In Instead')),
                  const SizedBox(
                    height: 25,
                  ),
                  if (_isLogin)
                    TextButton(
                        onPressed: _forgetPassword,
                        child: const Text('Forget Password?'))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
