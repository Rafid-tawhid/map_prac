
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.onPickedImage});
  final void Function(File image) onPickedImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
   File? _selectedImage;


  void _takePicture() async{
    final imagepicker= ImagePicker();
     final pickedImage=await imagepicker.pickImage(source: ImageSource.gallery,maxWidth: 600);
     if(pickedImage==null){
       return;
     }
     setState(() {
       _selectedImage=File(pickedImage.path);
     });

     widget.onPickedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {


    Widget content=TextButton.icon(
        onPressed: _takePicture,
        icon: Icon(Icons.camera),
        label: Text('Take Picture'));

    if(_selectedImage!=null){
      content=GestureDetector(
          onTap: _takePicture,
          child: Image.file(_selectedImage!,fit: BoxFit.cover,width: double.infinity,height: double.infinity,));
    }

    return Container(
      height: 250,
      padding: EdgeInsets.all(10 ),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.grey.withOpacity(.5))
      ),
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
