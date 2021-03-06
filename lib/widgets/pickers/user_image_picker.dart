import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) pickImageFn;

  UserImagePicker(this.pickImageFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50, // range frm 0-100, we do not need Hi Res
      maxWidth: 150, // specify size of image (I specified smaller smaller size)
    );

    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });

    widget.pickImageFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
