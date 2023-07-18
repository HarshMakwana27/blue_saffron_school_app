import 'package:flutter/material.dart';
import 'package:school/screens/teacher_login.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a category"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 30),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const TeacherLogin(),
                    ),
                  );
                },
                icon: const Icon(Icons.account_box),
                label: const Text("I am a Teacher")),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 30)),
                onPressed: () {},
                icon: const Icon(Icons.account_box),
                label: const Text("I am a parent"))
          ],
        ),
      ),
    );
  }
}
