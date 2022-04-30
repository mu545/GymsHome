import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/widgets/edit.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as Path;
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/Gymprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/widgets/AddGym.dart';
import 'package:gymhome/widgets/addimages.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/src/rendering/box.dart';
import 'add_image.dart';
import 'package:gymhome/GymOwnerwidgets/ManageImages.dart';

class ImageInput extends StatefulWidget {
  GymModel gym;
  File? imageFile;
  List<File?> imagesFile;
  ImageInput({
    Key? key,
    required this.imagesFile,
    required this.gym,
    required this.imageFile,
  }) : super(key: key);
  static const routenamed = '/locaaaa';

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Widget viewImages(BuildContext cxt) {
    // int length = imageFileList!.length + widget.gym.images!.length;
    if (widget.gym.gymId == '') {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: colors.blue_smooth)),
        height: 100,
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageFileList!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.all(3),
                  child: Image.file(
                    File(imageFileList![index].path),
                    fit: BoxFit.cover,
                  ));
            }),
      );
    } else {
      GymModel _gymProfile = GymModel(
          [], [], 0, 0, 0, 0, 0, '', '', '', '', '', '', false, true, '');
      return StreamBuilder(
        stream: _fireStore.collection('gyms').doc(widget.gym.gymId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> _data =
                snapshot.data.data() as Map<String, dynamic>;
            _gymProfile = GymModel.fromJson(_data);
            if (_gymProfile.images!.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 120),
                  child: Text(
                    'Tap any image to view all images',
                    style: TextStyle(
                        fontFamily: 'Roboto', color: colors.blue_base),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: colors.blue_smooth)),
                  height: 120,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _gymProfile.images!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ManageNewGymImages(
                                          images: _gymProfile.images,
                                        )));
                              },
                              child: Image.network(
                                _gymProfile.images![index],
                                height: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: -10,
                              left: -10,
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialogs(
                                            _gymProfile.images![index]));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: colors.black100,
                                  )),
                            )
                          ],
                        );
                      }),
                ),
              ],
            );
          }
          return Container();
        },
      );
    }
  }

  Widget AlertDialogs(img) {
    return AlertDialog(
      title: Text('Delete Image?'),
      actions: [
        FlatButton(
            onPressed: () {
              deleteImg(img);
              Navigator.pop(context);
            },
            child: Text('Delete')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
      ],
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 24,
      backgroundColor: colors.blue_smooth,
    );
  }

//delete img
  void deleteImg(imgUrl) {
    FirebaseFirestore.instance.collection('gyms').doc(widget.gym.gymId).update({
      'images': FieldValue.arrayRemove([imgUrl])
    });
    print(imgUrl);
  }

  List<File> newGymImages = [];
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<File> imgss = [];
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
      imgss.clear();
      for (var img in imageFileList!) {
        setState(() {
          imgss.add(File(img.path));
        });
      }
    }

    if (widget.gym.gymId != '') {
      for (var img in imgss) {
        FirebaseStorage storage = FirebaseStorage.instance;

        Reference ref =
            storage.ref().child('images/${Path.basename(img.path)}');
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            FirebaseFirestore.instance
                .collection('gyms')
                .doc(widget.gym.gymId)
                .update({
              'images': FieldValue.arrayUnion([value])
            });
          });
        });
      }
      imageFileList!.clear();
    } else {
      for (var img in imgss) {
        newGymImages.add(img);
      }
      print("New IMAGES" + newGymImages.length.toString());
    }
    print("Image List Length:" + imageFileList!.length.toString());
  }

  Widget displyText() {
    return Text(
      'Tap any image to view all images',
      style: TextStyle(fontFamily: 'Roboto', color: colors.blue_base),
    );
  }

  Widget facButton(String fac) {
    bool isHere = false;
    // bool notHere = false;
    if (widget.gym.faciltrs!.contains(fac)) {
      isHere = true;
    }
    return Container(
      height: 23,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: colors.blue_base),
      child: FlatButton(
        child: Text(
          fac,
          style: TextStyle(
              color: isHere ? Colors.white : colors.blue_base, fontSize: 13),
        ),
        color: isHere ? colors.blue_base : Colors.white,
        highlightColor: !isHere ? Colors.blue : Colors.white,
        onPressed: () {
          setState(() {
            addToArray(fac);
          });
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: colors.blue_base, width: 1, style: BorderStyle.solid),
        ),
      ),
    );
  }

  addToArray(String nameOfFac) {
    if (widget.gym.faciltrs!.contains('$nameOfFac'))
      widget.gym.faciltrs!.remove(nameOfFac);
    else
      widget.gym.faciltrs!.add(nameOfFac);
    print(widget.gym.faciltrs!);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add Gym ',
            style: TextStyle(color: Colors.white, fontFamily: 'Epilogue'),
          ),
        ),
        backgroundColor: colors.blue_base,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: 500,
              width: 390,
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            'Facilites',
                            style: TextStyle(
                                fontFamily: 'Epilogue',
                                fontSize: 30,
                                color: colors.blue_base),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 8,
                          height: 4,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              margin: EdgeInsets.only(left: 100),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: colors.blue_base),
                              child: FlatButton.icon(
                                icon: Icon(Icons.camera_alt_rounded,
                                    color: Colors.white),
                                onPressed: () {
                                  selectImages();
                                },
                                label: Text(
                                  "Upload Pictures",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              widget.gym.images!.isNotEmpty ||
                                      imageFileList!.isNotEmpty
                                  ? viewImages(context)
                                  : Container(),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Wrap(
                                  runSpacing: 10.0,
                                  spacing: 19.0,
                                  children: <Widget>[
                                    facButton('Pool'),
                                    facButton('Lounge Area'),
                                    facButton('Wifi'),
                                    facButton('Squash Courts'),
                                    facButton('Spin Studio'),
                                    facButton('Showrs'),
                                    facButton('Basketball Field'),
                                    facButton('Sauna'),
                                    facButton('Rowing'),
                                    facButton('Free Weights'),
                                    facButton('Steam Room'),
                                    facButton('Football Field'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colors.blue_base),
              child: FlatButton(
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GymPrice(
                            gym: widget.gym,
                            imageFile: widget.imageFile,
                            newGymImages: newGymImages,
                          )));
                },
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: colors.blue_base,
                    fontFamily: 'Roboto',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: colors.blue_base,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
              ),
            )
          ],
        ),
      ),
    );
  }

  getApplicationDocumentsDirectory() {}
}
