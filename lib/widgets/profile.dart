import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymhome/widgets/imageinput.dart';
import 'package:gymhome/widgets/welcome.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/widgets/resetpass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isedit = false;
  String newName = '';
  //final _auth = FirebaseAuth.instance;
  bool isNameValid = true;

  TextEditingController _nameTEC = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  File? _imageFile;

  Future getImageGallery() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // final imageTemp = File(image.path);
    final imageParmenant = await saveImageParmanetly(image.path);
    setState(() {
      this._imageFile = imageParmenant;
    });
  }

  Future<File> saveImageParmanetly(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future getImageCamera() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      this._imageFile = imageTemp;
    });
  }

/*  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker.platform.getImage(
      source: source,
    ) as File;
    setState(() {
      _imageFile = pickedFile;
    });
  } */

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      // width: MediaQuery.of(context).size.width,
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
          ])
        ],
      ),
    );
  }

  Widget iconEdit() {
    if (isedit == false)
      return Icon(
        Icons.edit,
        color: Colors.blueGrey,
      );
    else
      return Icon(
        Icons.check,
        color: Colors.blueGrey,
      );
  }

  var userEmail = FirebaseAuth.instance.currentUser!.email;

  // Trying other way

  Future getEmail() async {
    // var userEmail = FirebaseAuth.instance.currentUser!.email;
    var userName = FirebaseFirestore.instance
        .collection('Customer')
        .doc(userEmail)
        .get()
        .then(
      (snapshot) {
        snapshot.data().toString();
      },
    );
  }
  //var userName = FirebaseFirestore.instance.collection('Customer').doc(FirebaseAuth.instance.currentUser!.email).get();
  //                     var docSnapshot = await collection.doc(auth).get();
  //                      if (docSnapshot.exists

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Epilogue'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: <Widget>[
                              _imageFile != null
                                  ? ClipOval(
                                      child: Image.file(
                                        _imageFile!,
                                        width: 160,
                                        height: 160,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 80.0,
                                      backgroundImage: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDq2REE_qNK1VtPuYlIy6orJZSsZoo6p8kTQ&usqp=CAU'),
                                    ),
                              Positioned(
                                bottom: 20,
                                right: 20,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
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

                        //      Row(
                        //        mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         IconButton(
                        //              onPressed: () {
                        //                setState(() {
                        //                 isedit = true;
                        //               });
                        //             },
                        //             icon: Icon(Icons.edit)),
                        //       ],
                        //     ),
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
                                      controller: _nameTEC,
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
                                      //          keyboardType: TextInputType.name,
                                      //             validator: (value) {
                                      //               if (value!.isEmpty) {
                                      //                 return 'Invalid Name';
                                      //                }
                                      //               },
                                      //               onSaved: (value) {
                                      //                 newName = value!;
                                      //                },
                                    )
                                  : Text(
                                      _nameTEC.text,
                                      style: TextStyle(fontFamily: 'Epilogue'),
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isedit == true)
                                    isedit = false;
                                  else
                                    isedit = true;
                                });
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
                              /*            child: isedit
                                    ? TextFormField(
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
                                          hintText: "Enter your email",
                                          hintStyle: TextStyle(
                                            color: colors.hinttext,
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        // validator: (value) {
                                        //   if (value!.isEmpty || !value.contains('@')) {
                                        //     return 'Invalid email!';
                                        //   }
                                        // },
                                        // onSaved: (value) {
                                        //   _authData['email'] = value!;
                                        // },
                                      )
                                    : */
                            ),
                          ],
                        ),
                        /*  Row(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('Password')),
                            SizedBox(
                              width: 2,
                            ),
                               Expanded(
                                  child: Text("***********"),
                                 )
                                                 child: isedit
                                    ? TextFormField(
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
                                          hintText: "Enter password",
                                          hintStyle: TextStyle(
                                            color: colors.hinttext,
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        // validator: (value) {
                                        //   if (value!.isEmpty || !value.contains('@')) {
                                        //     return 'Invalid email!';
                                        //   }
                                        // },
                                        // onSaved: (value) {
                                        //   _authData['email'] = value!;
                                        // },
                                      )
                                    : 
                          ],
                        ),*/
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
                                        borderRadius: BorderRadius.circular(20),
                                        color: colors.blue_base),
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
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
                          //        FirebaseAuth.instance.signOut();
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
