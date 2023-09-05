import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({super.key});

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  String? imageUrl;
  List<XFile> _pickedFiles = [];
  Future<void> selectImageFromCamera() async {
    try {
      final selectedImage = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      if (selectedImage != null) {
        setState(() {
          _pickedFiles.add(selectedImage);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  // Function to select an image from the gallery
  Future<void> selectImage() async {
    try {
      final selectedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (selectedImage != null) {
        setState(() {
          _pickedFiles.add(selectedImage);
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  // Future<void> _cropImage() async {
  //   if (_pickedFile != null) {
  //     final croppedFile = await ImageCropper().cropImage(
  //       sourcePath: _pickedFile!.path,
  //       compressFormat: ImageCompressFormat.jpg,
  //       compressQuality: 100,
  //       aspectRatioPresets: [CropAspectRatioPreset.original],
  //       uiSettings: [
  //         AndroidUiSettings(
  //             toolbarTitle: 'Cropper',
  //             toolbarColor: Colors.deepOrange,
  //             toolbarWidgetColor: Colors.white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false),
  //       ],
  //     );
  //     if (croppedFile != null) {
  //       setState(() {
  //         _croppedFile = croppedFile;
  //       });
  //     }
  //   }
  // }

  Future<void> uploadImage() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('student_images');

      for (var file in _pickedFiles!) {
        await storageRef.putFile(File(file.path));
      }

      imageUrl = await storageRef.getDownloadURL();
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  // Widget _image() {
  //   if (_pickedFiles.isNotEmpty) {
  //     return ListView.builder(
  //         itemCount: _pickedFiles.length,
  //         itemBuilder: ((context, index) {
  //           return
  //         }));
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              // Add controller and other properties as needed
              decoration: InputDecoration(
                  labelText: 'Enter folder name', border: OutlineInputBorder()),
            ),
          ),
          if (_pickedFiles.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for (var file in _pickedFiles)
                    Container(
                      // height: MediaQuery.sizeOf(context).height * 0.3,
                      // width: MediaQuery.sizeOf(context).height * 0.5,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Image.file(
                        File(file.path),
                      ),
                    ),
                ],
              ),
            ),
          TextButton.icon(
            label: const Text('Select from gallary'),
            onPressed: selectImage,
            icon: const Icon(CupertinoIcons.photo),
          ),
          const SizedBox(width: 20),
          TextButton.icon(
            label: const Text('Upload from camera'),
            onPressed: selectImageFromCamera,
            icon: const Icon(CupertinoIcons.photo_camera),
          ),
          ElevatedButton(
            onPressed: () {
              // Add functionality to the button
            },
            child: const Text('Save Photos'),
          ),
        ]),
      ),
    );
  }
}
