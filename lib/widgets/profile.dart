import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:gymhome/GymOwnerwidgets/facilities.dart';
import 'package:gymhome/authintactions/auth.dart';
import 'package:gymhome/provider/customer.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymhome/authintactions/database.dart';
import 'package:gymhome/provider/customer.dart';
import 'package:gymhome/models/user.dart';
import 'package:gymhome/widgets/edit.dart';
import 'package:gymhome/widgets/imageinput.dart';
import 'package:gymhome/widgets/welcome.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/widgets/resetpass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gymhome/authintactions/database.dart';
import 'package:provider/provider.dart';

import 'package:gymhome/models/profile_model.dart';

class Profile extends StatefulWidget {
  final String userid;
  const Profile({required this.userid, Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isedit = false;
  bool uploading = false;
  TextEditingController _nameTEC = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Widget iconEdit() {
    if (isedit == false) {
      return Icon(
        Icons.edit,
        color: Colors.blueGrey,
      );
    } else {
      return Icon(
        Icons.check,
        color: Colors.blueGrey,
      );
    }
  }

  File? _imageFile;

// get image method GALLERY
  Future getImageGallery() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);
    setState(() {
      _imageFile = imageTemp;
    });
  }

// get image method CAMERA
  Future getImageCamera() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      _imageFile = imageTemp;
    });
  }

  Future uploadPicForUserProfile() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("$userId" + " ProfilePic " + DateTime.now().toString());
    await ref.putFile(_imageFile!);
    String imageurl = await ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection('Customer')
        .doc(userId)
        .update({'profilePicture': imageurl});
  }

  @override
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser!.uid;
  var userEmail = FirebaseAuth.instance.currentUser!.email;
  ProfileModel _userProfile = ProfileModel('', '');
  Future? _getData() => _fireStore.collection('Customer').doc(userId).get();
  String? name;
  @override
  Widget build(BuildContext context) {
    Widget bottomSheet() {
      return Container(
        height: 150,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Choose Profile Photo",
              style: TextStyle(
                fontFamily: 'Epilouge',
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton.icon(
                        icon: Icon(Icons.camera),
                        onPressed: () {
                          getImageCamera();
                        },
                        label: Text("Camera"),
                      ),
                      FlatButton.icon(
                        icon: Icon(Icons.image),
                        onPressed: () {
                          getImageGallery();
                        },
                        label: Text("Gallery"),
                      ),
                    ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      if (_imageFile != null) {
                        setState(() {
                          uploading = true;
                        });
                        Navigator.of(context).pop();
                        uploadPicForUserProfile().whenComplete(() {
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              uploading = false;
                              message(
                                  context, true, 'Profile Picture Uploaded');
                            });
                          });
                        });
                      } else {
                        Navigator.of(context).pop();
                        message(context, false, 'You didn\'t choose new image');
                      }
                    },
                    label: Text("Submit Photo"),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.cancel_outlined),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _imageFile = null;
                      });
                    },
                    label: Text("Cancel"),
                  ),
                ]),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.blue_base,
        title: Text(
          'My Account',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Epilogue'),
        ),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext contextBody) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    Card(
                      shadowColor: colors.blue_base,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Stack(
                              children: <Widget>[
                                _imageFile == null
                                    ? StreamBuilder(
                                        stream: _fireStore
                                            .collection("Customer")
                                            .doc(userId)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasData) {
                                            Map<String, dynamic> _data =
                                                snapshot.data.data()
                                                    as Map<String, dynamic>;
                                            _userProfile =
                                                ProfileModel.fromJson(_data);
                                            return CircleAvatar(
                                              radius: 80.0,
                                              backgroundImage: NetworkImage(
                                                  _userProfile.userImage ?? ''),
                                            );
                                          } else
                                            return CircleAvatar(
                                              radius: 80.0,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: colors.blue_base,
                                              )),
                                            );
                                        })
                                    : CircleAvatar(
                                        radius: 80.0,
                                        backgroundImage:
                                            FileImage(_imageFile!)),
                                Positioned(
                                  bottom: 20,
                                  right: 20,
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: contextBody,
                                        builder: ((builder) => bottomSheet()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: colors.blue_base,
                                      size: 24,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Name:',
                                  style: TextStyle(fontFamily: 'Epilogue'),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: isedit
                                    ? TextFormField(
                                        initialValue: name,
                                        onChanged: (value) {
                                          name = value;
                                        },
                                        //    controller: _nameTEC,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      62, 99, 99, 99)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colors.blue_base),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "Enter your name",
                                          hintStyle: TextStyle(
                                            color: colors.hinttext,
                                          ),
                                        ),
                                      )
                                    : FutureBuilder(
                                        future: _getData(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasData) {
                                            Map<String, dynamic> _data =
                                                snapshot.data.data()
                                                    as Map<String, dynamic>;
                                            _userProfile =
                                                ProfileModel.fromJson(_data);
                                            name = _userProfile.userName;
                                            return Text(
                                              '${_userProfile.userName}',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                              ),
                                            );
                                          } else
                                            return Text('........');
                                        }),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (name!.isEmpty) {
                                    message(context, false,
                                        'Name cannot be empty!');
                                  } else if (name!.length <= 2) {
                                    message(
                                        context, false, 'Name is too short!');
                                  } else {
                                    setState(() {
                                      if (isedit == true) {
                                        isedit = false;
                                        FirebaseFirestore.instance
                                            .collection("Customer")
                                            .doc(userId)
                                            .update({'name': name});
                                      } else {
                                        isedit = true;
                                      }
                                    });
                                  }
                                },
                                icon: iconEdit(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Email:',
                                    style: TextStyle(fontFamily: 'Epilogue'),
                                  )),
                              SizedBox(
                                width: 20,
                                height: 50,
                              ),
                              Expanded(
                                child: Text('$userEmail'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                height: 30,
                                minWidth: 10,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const resetpassword()));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: colors.blue_base),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Reset Password',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                              height: 80,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              child: Icon(
                                                Icons.password,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          onPressed: () {
                            // Provider.of<Auth>(context, listen: false).logout();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Center(
                                    child: Text(
                                      'LogOut',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 40,
                                    margin: EdgeInsets.symmetric(horizontal: 0),
                                    child: Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
