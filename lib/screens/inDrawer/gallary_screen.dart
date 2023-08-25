import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school/widgets/addphotos.dart';
import 'package:transparent_image/transparent_image.dart';

class GallaryScreen extends StatefulWidget {
  const GallaryScreen({super.key, required this.isTeacher});

  final bool isTeacher;

  @override
  State<GallaryScreen> createState() => _GallaryScreenState();
}

class _GallaryScreenState extends State<GallaryScreen> {
  final _collection = FirebaseFirestore.instance.collection('photos');
  late List<String> folders = [];

  Future<List<String>> _loadFolders() async {
    folders.clear();
    final snapshots = await _collection.get();

    for (var doc in snapshots.docs) {
      folders.add(doc.id);
    }

    return folders;
  }

  void _addPhotos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPhotosScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Photos',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w400, color: Colors.white)),
        leading: Builder(
          builder: (BuildContext context) {
            return const BackButton(
              color: Colors.white,
            );
          },
        ),
        actions: [
          if (widget.isTeacher)
            IconButton(
              onPressed: _addPhotos,
              icon: const Icon(Icons.add),
              color: Colors.white,
            )
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _loadFolders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to load images'),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No photos'));
          }
          return ListView.builder(
              itemCount: folders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(folders[index]),
                );
              });
        },
      ),
    );
  }
}
