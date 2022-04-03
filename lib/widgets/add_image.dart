import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/widgets/AddGym.dart';
import 'package:gymhome/widgets/imageinput.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import '../GymOwnerwidgets/gymprice.dart';

class AddImage extends StatefulWidget {
  GymModel gym;
  List<File?> imagesFile;
  File? imageFile;
  AddImage({
    Key? key,
    required this.gym,
    required this.imageFile,
    required this.imagesFile,
  }) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploading = false;
  double val = 0;
  List<File> _image = [];

  //late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: colors.blue_base,
          title: Text(
            "Add Images",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  for (var img in _image) {
                    setState(() {
                      widget.imagesFile.add(img);
                    });
                  }

                  print(_image);
                  Navigator.pop(context);
                  //Navigator.pop(context);
                  // Provider.of<AddGymMethods>(context, listen: false)
                  //     .uploadFiles(_image)
                  //     .whenComplete(() => Navigator.of(context).push(
                  //         MaterialPageRoute(
                  //             builder: (context) => ImageInput())));
                },
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ))
          ]),
      body: Stack(
        children: [
          GridView.builder(
              itemCount: imageFileList!.length + 1,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            !uploading ? selectImages() : null;
                          },
                        ),
                      )
                    : Image.file(
                        File(imageFileList![index].path),
                        fit: BoxFit.cover,
                      );
              }),
          uploading
              ? Center(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        'uploading...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                      value: val,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(colors.blue_base),
                    )
                  ],
                ))
              : Container(),
        ],
      ),
    );
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  // chooseImage() async {
  //   final pickedFile =
  //       await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image.add(File(pickedFile!.path));
  //   });
  //   if (pickedFile!.path == null) retrieveLostData();
  // }

  // Future<void> retrieveLostData() async {
  //   final LostDataResponse response = await ImagePicker.platform.getLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     setState(() {
  //       _image.add(File(response.file!.path));
  //     });
  //   } else {
  //     print(response.file);
  //   }
  // }

  // Future uploadFile() async {
  //   int i = 1;

  //   for (var img in _image) {
  //     setState(() {
  //       val = i / _image.length;
  //     });
  //     ref = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('images/${Path.basename(img.path)}');
  //     await ref.putFile(img).whenComplete(() async {
  //       await ref.getDownloadURL().then((value) {
  //         FirebaseFirestore.instance
  //             .collection('Gyms')
  //             .doc('95fFRxumpsU3TI6jXi1K')
  //             .update({
  //           'images': FieldValue.arrayUnion([value])
  //         });
  //         i++;
  //       });
  //     });
  //   }
  // }
}
