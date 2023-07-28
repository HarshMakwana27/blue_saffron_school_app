import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:school/widgets/contact_card.dart';

class Contact extends StatelessWidget {
  const Contact({super.key, required this.isStudent});

  final bool isStudent;
  @override
  Widget build(BuildContext context) {
    final usersStream = FirebaseFirestore.instance
        .collection('users')
        .where('isStudent', isEqualTo: !isStudent)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: usersStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          try {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final loadedMessage =
                snapshot.data?.docs ?? []; // Safely handle null value

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: loadedMessage.length,
                itemBuilder: (ctx, index) {
                  // Check if the index is valid
                  if (index >= 0 && index < loadedMessage.length) {
                    final student = loadedMessage[index].data();

                    return ContactCard(student);
                  } else {
                    return const Text("Invalid index");
                  }
                },
              ),
            );
          } catch (e) {
            return Center(child: Text('Error: $e'));
          }
        },
      ),
    );
  }
}
