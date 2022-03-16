import 'dart:io';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/Gymprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/widgets/addimages.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/src/rendering/box.dart';

import 'add_image.dart';

class ImageInput extends StatefulWidget {
  static const routenamed = '/locaaaa';

  @override
  // Function onselectimage;
  ImageInput();
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;
  bool _onpresss1 = false;
  bool _onpresss2 = false;
  bool _onpresss3 = false;
  bool _onpresss4 = false;
  bool _onpresss5 = false;
  bool _onpresss6 = false;
  bool _onpresss7 = false;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String userId = "95fFRxumpsU3TI6jXi1K";
  GymModel _gymProfile =
      GymModel([], [], 0, 0, 0, 0, 0, '', '', '', '', '', '', false, true);

  Future? _getData() => _fireStore.collection('Gyms').doc(userId).get();

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
          // Text(
          //   "Choose Profile photo",
          //   style: TextStyle(
          //     fontSize: 20.0,
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[])
        ],
      ),
    );
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
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {
        //       bottomSheet();
        //     },
        //     icon: Icon(
        //       Icons.more_vert,
        //       color: Colors.black,
        //     ),
        //   )
        // ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 400,
            width: 390,
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            // Text('Pool'),  MyStatefulWidget() ,   Text('Sauna'),    MyStatefulWidget() ,    Text('Rowing'),   MyStatefulWidget() ,   Text('Squash'),    MyStatefulWidget() ,
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                        height: 4,
                      ),
                      Row(
                        children: [],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 80),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: colors.blue_base),
                            child: FlatButton.icon(
                              icon: Icon(Icons.camera_alt_rounded,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddImage()));
                                //              getImageCamera();
                              },
                              label: Text(
                                "View & Upload Pictures",
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
                        height: 60,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 73,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.blue_base),
                                  child: FlatButton(
                                    child: Text(
                                      'Pool',
                                      style: TextStyle(
                                          color: _onpresss2
                                              ? Colors.white
                                              : colors.blue_base,
                                          fontSize: 13),
                                    ),
                                    color: _onpresss2
                                        ? colors.blue_base
                                        : Colors.white,
                                    highlightColor:
                                        _onpresss1 ? Colors.blue : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _onpresss2 = !_onpresss2;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: colors.blue_base,
                                          width: 1,
                                          style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 73,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.blue_base),
                                  child: FlatButton(
                                    child: Text(
                                      'Sauna',
                                      style: TextStyle(
                                          color: _onpresss1
                                              ? Colors.white
                                              : colors.blue_base,
                                          fontSize: 13),
                                    ),
                                    color: _onpresss1
                                        ? colors.blue_base
                                        : Colors.white,
                                    highlightColor:
                                        _onpresss1 ? Colors.blue : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _onpresss1 = !_onpresss1;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: colors.blue_base,
                                          width: 1,
                                          style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 83,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.blue_base),
                                  child: FlatButton(
                                    child: Text(
                                      'Rowing',
                                      style: TextStyle(
                                          color: _onpresss3
                                              ? Colors.white
                                              : colors.blue_base,
                                          fontSize: 13),
                                    ),
                                    color: _onpresss3
                                        ? colors.blue_base
                                        : Colors.white,
                                    highlightColor:
                                        _onpresss3 ? Colors.blue : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _onpresss3 = !_onpresss3;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: colors.blue_base,
                                          width: 1,
                                          style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 83,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.blue_base),
                                  child: FlatButton(
                                    child: Text(
                                      'Squach',
                                      style: TextStyle(
                                          color: _onpresss4
                                              ? Colors.white
                                              : colors.blue_base,
                                          fontSize: 13),
                                    ),
                                    color: _onpresss4
                                        ? colors.blue_base
                                        : Colors.white,
                                    highlightColor:
                                        _onpresss4 ? Colors.blue : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _onpresss4 = !_onpresss4;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: colors.blue_base,
                                          width: 1,
                                          style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 150,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.blue_base),
                                child: FlatButton(
                                  child: Text(
                                    'Indoor Runing Track',
                                    style: TextStyle(
                                        color: _onpresss5
                                            ? Colors.white
                                            : colors.blue_base,
                                        fontSize: 13),
                                  ),
                                  color: _onpresss5
                                      ? colors.blue_base
                                      : Colors.white,
                                  highlightColor:
                                      _onpresss5 ? Colors.blue : Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _onpresss5 = !_onpresss5;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: colors.blue_base,
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                ),
                              ),
                              Container(
                                width: 83,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.blue_base),
                                child: FlatButton(
                                  child: Text(
                                    'Khijih',
                                    style: TextStyle(
                                        color: _onpresss7
                                            ? Colors.white
                                            : colors.blue_base,
                                        fontSize: 13),
                                  ),
                                  color: _onpresss7
                                      ? colors.blue_base
                                      : Colors.white,
                                  highlightColor:
                                      _onpresss7 ? Colors.blue : Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _onpresss7 = !_onpresss7;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: colors.blue_base,
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 97,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.blue_base),
                                child: FlatButton(
                                  child: Text(
                                    'Stram Bath',
                                    style: TextStyle(
                                        color: _onpresss6
                                            ? Colors.white
                                            : colors.blue_base,
                                        fontSize: 13),
                                  ),
                                  color: _onpresss6
                                      ? colors.blue_base
                                      : Colors.white,
                                  highlightColor:
                                      _onpresss6 ? Colors.blue : Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _onpresss6 = !_onpresss6;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: colors.blue_base,
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                Navigator.of(context).pushNamed(GymPrice.routenames);
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
              onPressed: () {},
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
    );
  }

  getApplicationDocumentsDirectory() {}
}
