import 'package:flutter/material.dart';

import 'package:school/screens/auth/reg_screen.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    bool? isStudent;
    // final height = MediaQuery.of(context).size.height;
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
                  isStudent = false;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => RegScreen(
                        isStudent: isStudent!,
                      ),
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
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  fixedSize: Size(width * 0.9, 50),
                ),
                onPressed: () {
                  isStudent = true;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => RegScreen(
                        isStudent: isStudent!,
                      ),
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
