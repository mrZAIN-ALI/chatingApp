import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakeImage extends StatefulWidget {
  const TakeImage(this.takeImageFunction);
  final void Function(XFile ImagePicked) takeImageFunction;
  @override
  State<TakeImage> createState() => _TakeImageState();
}

class _TakeImageState extends State<TakeImage> {
  //
  XFile? _tookImage;
  void _takeImage() async {
    final imagePicker = ImagePicker();
    final tookImage= await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if(tookImage!=null){

    setState(() {
    _tookImage=tookImage;
    });
    }

    widget.takeImageFunction(_tookImage as XFile);
  }

  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _takeImage,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: _tookImage ==null ? Text(
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
          softWrap: true,
          "Tap to Add Image",
          textAlign: TextAlign.center,
        ) : null,
        radius: 45,
        backgroundImage: _tookImage !=null ? FileImage(File(_tookImage!.path)) : null,
      ),
    );
  }
}
