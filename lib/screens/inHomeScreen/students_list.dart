import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school/widgets/student_tile.dart';

class StudentList extends StatefulWidget {
  const StudentList(
      {super.key,
      required this.selectedMedium,
      required this.selectedStandard});

  final String selectedMedium;
  final String selectedStandard;

  @override
  State<StudentList> createState() {
    return _StudentListState();
  }
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    final usersStream = FirebaseFirestore.instance
        .collection(
            'students/${widget.selectedMedium}/${widget.selectedStandard}')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students List"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Text(widget.selectedMedium.capitalize()),
                  const Icon(Icons.arrow_right),
                  Text(widget.selectedStandard)
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                  if (loadedMessage.isEmpty) {
                    return const Center(child: Text("No data"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: loadedMessage.length,
                    itemBuilder: (ctx, index) {
                      // Check if the index is valid
                      if (loadedMessage.isEmpty) {
                        return const Center(child: Text("No data"));
                      }
                      if (index >= 0 && index < loadedMessage.length) {
                        final student = loadedMessage[index].data();
                        return StudentTile(student);
                      } else {
                        return const Text("Invalid index");
                      }
                    },
                  );
                } catch (e) {
                  return Center(child: Text('Error: $e'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
