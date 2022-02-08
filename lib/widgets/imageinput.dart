import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  @override
  Function onselectimage;
  ImageInput(this.onselectimage);
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
   File ? _saveimage   ;
  @override
   Future<void> _takedpicture() async {
    File Imagefile =
        await ImagePicker.platform.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
      maxHeight: null,
      imageQuality: null,
      preferredCameraDevice: CameraDevice.rear,
    ) as File;

    setState(() {
      _saveimage = Imagefile;
    });

    final appdur =
        await syspath.getApplicationDocumentsDirectory(); //to save Image local
    final filename = path.basename(Imagefile.path);
    final savedimagess = await Imagefile.copy('${appdur.path} /$filename');
    widget.onselectimage(savedimagess);
  }
   

  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
           
            FlatButton.icon(
              onPressed: _takedpicture,
              icon: Icon(
                Icons.camera,
                color: Colors.blue,
              ),
              label: Text('Take picture'),
            ), 
          ],
        ),
         Container(
          height: 150,
          width: 350,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _saveimage != null
              ? Image.file(
                  _saveimage! ,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('H'),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
