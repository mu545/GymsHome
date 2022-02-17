import 'dart:convert';
import 'dart:io';
import 'package:gymhome/models/customer.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymhome/authintactions/database.dart';
import 'package:gymhome/models/customer.dart';
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
import 'package:gymhome/widgets/customer_list.dart';
import 'package:gymhome/models/profile_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isedit = false;

  TextEditingController _nameTEC = TextEditingController();

  //read data
  //read() async {
  //  StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('Customer').snapshots(),
  //    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //      if (snapshot.hasData) {
  //      return ListView.builder(
  //           itemCount: snapshot.data!.docs.length,
  //          itemBuilder: (context, i) {
  //           QueryDocumentSnapshot x = snapshot.data!.docs[i];
  //            return Text(x['Email']);
  //          });
  //     }
  //      return Center(
  //        child: CircularProgressIndicator(),
  //      );
  //     });
  //}

  final FirebaseAuth auth = FirebaseAuth.instance;

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

  // void initState() {
//    setState(() {
  //     username = readsName() as String?;
//    });
  // }

// get image method CAMERA
  Future getImageCamera() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      this._imageFile = imageTemp;
    });
  }

  Widget iconEdit() {
    if (isedit == false) {
      //  readsName();
      return Icon(
        Icons.edit,
        color: Colors.blueGrey,
      );
    } else {
      //    readsName();
      return Icon(
        Icons.check,
        color: Colors.blueGrey,
      );
    }
  }

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  var userEmail = FirebaseAuth.instance.currentUser!.email;
  ProfileModel _userProfile = ProfileModel('');
  Future? _getData() => _fireStore.collection('Customer').doc(userEmail).get();

  @override
  Widget build(BuildContext context) {
    // TO DATABASE

    uploadPic() async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child("$userEmail" + " ProfilePic " + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_imageFile!);
      uploadTask.then((res) {
        res.ref.getDownloadURL();
      });
      setState(() {
        print("Profile Picture Uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

// TRY TO MAKE IT DISAPER?
    Widget bottomSheet() {
      return Container(
        height: 150,
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
                      FlatButton.icon(
                        icon: Icon(Icons.abc),
                        onPressed: () {},
                        label: Text("Camera"),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton.icon(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          //try parametter
                          uploadPic();
                        },
                        label: Text("Submit Photo"),
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
                                            return Text(
                                                '${_userProfile.userName}');
                                          } else
                                            return Text('....');
                                        }),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (isedit == true) {
                                      isedit = false;
                                      FirebaseFirestore.instance
                                          .collection("Customer")
                                          .doc(userEmail)
                                          .set({'name': _nameTEC.text});
                                      //     username = _nameTEC.text;
                                    } else {
                                      isedit = true;
                                    }
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
                          //      CustomerList(),
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
                    //  CustomerList(),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //  ),
    );
  }
}
