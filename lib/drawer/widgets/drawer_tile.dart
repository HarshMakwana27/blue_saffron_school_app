import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:school/screens/gallary_screen.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(this.title, this.icon, this.widget, {super.key});

  final String title;
  final IconData icon;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      horizontalTitleGap: 20,
      leading: Icon(
        icon,
        color: const Color.fromARGB(255, 0, 0, 0),
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 18),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
    );
  }
}
