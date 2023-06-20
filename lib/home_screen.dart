import 'package:flutter/material.dart';

import 'package:school/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Blue Saffron School',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600, color: Colors.white)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Column(
        children: [
          const Text(
            'This is normal',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          Text('This is normal',
              style: Theme.of(context).textTheme.titleMedium!),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
