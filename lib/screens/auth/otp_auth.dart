import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetPhoneNumber extends StatelessWidget {
  const GetPhoneNumber({required this.isExistingUser, Key? key})
      : super(key: key);

  final bool isExistingUser;

  void _onSubmitPhoneNumber(BuildContext context, String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) =>
            verificationCompleted(phoneAuthCredential, context),
        verificationFailed: verificationFailed,
        codeSent: (verificationId, [code]) => codeSent(context, verificationId),
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  void verificationCompleted(
      PhoneAuthCredential phoneAuthCredential, BuildContext context) {
    print('verificationCompleted');
    // You can directly call the login function here if you want to automatically sign in the user
    //_login(context, phoneAuthCredential);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          phoneNumber: phoneAuthCredential.smsCode!,
          isExistingUser: isExistingUser,
        ),
      ),
    );
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed: ${error.message}');
  }

  void codeSent(BuildContext context, String verificationId) {
    print('codeSent');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          phoneNumber: verificationId,
          isExistingUser: isExistingUser,
        ),
      ),
    );
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: phoneNumController,
            decoration: const InputDecoration(hintText: 'Enter phone number'),
            onChanged: (value) {
              phoneNumController.text = value.trim();
            },
          ),
          ElevatedButton(
            onPressed: () {
              _onSubmitPhoneNumber(context, phoneNumController.text);
            },
            child: const Text('Send OTP'),
          )
        ],
      ),
    );
  }
}

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen(
      {required this.phoneNumber, required this.isExistingUser, Key? key})
      : super(key: key);

  final String phoneNumber;
  final bool isExistingUser;

  void _login(BuildContext context, String otpCode) {
    FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: phoneNumber, smsCode: otpCode));
  }

  @override
  Widget build(BuildContext context) {
    String otpCode = ''; // Add this to store the entered OTP
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter OTP sent to $phoneNumber'),
            TextFormField(
              onChanged: (value) {
                otpCode = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logic to verify OTP here
                if (otpCode.isNotEmpty) {
                  _login(context, otpCode);
                }
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
