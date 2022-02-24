import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/widgets/checkbox.dart';
import 'package:gymhome/widgets/imageinput.dart';

class Facilites extends StatefulWidget {
  static const routenames = '/srs';
  const Facilites({Key? key}) : super(key: key);

  @override
  _AddGymState createState() => _AddGymState();
}

class _AddGymState extends State<Facilites> {
  File? _imagesave;
  void _selectedimage(File Imagefile) {
    _imagesave = Imagefile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Add Gym ',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 450,
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
                                style:
                                    TextStyle(fontSize: 30, color: Colors.blue),
                              )),
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
                            children: [
                              // Text('Lockers'),    MyStatefulWidget() ,
                              //                  Text('Steam Bord'),    MyStatefulWidget() ,
                              //                             Container(
                              //                   margin: EdgeInsets.symmetric(horizontal: 8),
                              //                             width: 100,
                              //                             height: 25,
                              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                              //                             child: FlatButton(

                              //                               child: Text('Steam Bath',style: TextStyle(color: Colors.blue, fontSize: 13),),
                              //                               color: Colors.white,
                              //                               onPressed: () {/** */},
                              //                               shape: RoundedRectangleBorder(side: BorderSide(
                              //   color: Colors.blue,
                              //   width: 1,
                              //   style: BorderStyle.solid
                              // ),
                              //                             ),
                              //                           ),

                              //                            ),
                            ],
                          ),
                          //     ImageInput(_selectedimage)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 250,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: FlatButton(
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(GymPrice.routenames);
                          },
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 4),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: FlatButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 4),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          textColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
