import 'package:flutter/material.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;

  bool _isLoading = false;

  String _email = '';
  String _password = '';
  String _username = '';

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_email);
      print(_password);
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
                      style: const TextStyle(color: Colors.white),
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
                        _username = value!;
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
                          _isLogin ? 'Create an Account' : 'Log In Instead'))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
