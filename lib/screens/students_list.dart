import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class studentList extends StatefulWidget {
  const studentList({super.key});

  @override
  State<studentList> createState() {
    return _studentListState();
  }
}

class _studentListState extends State<studentList> {
  final _usersStream =
      FirebaseFirestore.instance.collection('students/english/kg1').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _usersStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          final loadedMessage =
              snapshot.data?.docs ?? []; // Safely handle null value

          return ListView.builder(
            itemCount: loadedMessage.length,
            itemBuilder: (ctx, index) {
              // Check if the index is valid
              if (index >= 0 && index < loadedMessage.length) {
                final name = loadedMessage[index].data()['name'];
                return Text(name);
              } else {
                // Handle the case where the index is out of bounds
                return const Text("Invalid index");
              }
            },
          );
        },
      ),
    );
  }
}
