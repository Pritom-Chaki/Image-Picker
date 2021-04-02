import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgPermission extends StatefulWidget {
  @override
  _ImgPermissionState createState() => _ImgPermissionState();
}

class _ImgPermissionState extends State<ImgPermission> {
  File _image;
  ImagePicker imagePicker;
  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  Future<void> openGallry() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future<void> openCamera() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Permission"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null ? Image.file(_image) : Icon(Icons.image, size: 100),
            ElevatedButton(
              child: Text("Image Picker"),
              onPressed: openGallry,
              onLongPress: openCamera,
            )
          ],
        ),
      ),
    );
  }
}
