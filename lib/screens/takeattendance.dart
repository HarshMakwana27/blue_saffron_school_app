import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school/widgets/student_tile.dart';
import 'package:school/screens/stepper.dart';

class TakeAttendance extends StatefulWidget {
  const TakeAttendance({
    super.key,
  });

  @override
  State<TakeAttendance> createState() {
    return _TakeAttendanceState();
  }
}

class _TakeAttendanceState extends State<TakeAttendance> {
  List<String> uids = [];
  List<bool> isPresentList = [];

  @override
  Widget build(BuildContext context) {
    final usersStream = FirebaseFirestore.instance
        .collection('students/$medium/$standard')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take Attendance"),
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

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: loadedMessage.length,
                    itemBuilder: (ctx, index) {
                      // Check if the index is valid
                      if (index >= 0 && index < loadedMessage.length) {
                        final student = loadedMessage[index].data();
                        return StudentTile(student);
                      } else {
                        return const Text("Invalid index");
                      }
                    },
                  ),
                ),
              ],
            );
          } catch (e) {
            return Center(child: Text('Error: $e'));
          }
        },
      ),
    );
  }
}
