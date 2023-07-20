import 'package:flutter/material.dart';
import 'package:school/screens/reg_screen.dart';

bool? isTeacher;

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                    fixedSize: Size(width * 0.9, 50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  isTeacher = true;
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: Size(width * 0.9, 50),
                ),
                onPressed: () {
                  isTeacher = false;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const TeacherLogin(),
                    ),
                  );
                },
                icon: const Icon(Icons.account_box),
                label: const Text("I am a parent"))
          ],
        ),
      ),
    );
  }
}
