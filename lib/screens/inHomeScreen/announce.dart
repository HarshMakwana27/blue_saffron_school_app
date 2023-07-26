import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  void setupNotification() async {
    final fm = FirebaseMessaging.instance;
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    await fm.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }

  @override
  void initState() {
    setupNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement'),
      ),
    );
  }
}
