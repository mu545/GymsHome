import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/gyms.dart';

import 'package:gymhome/widgets/imageinput.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'locationmap.dart';

message(BuildContext cxt, bool iserror, String message) {
  ScaffoldMessenger.of(cxt).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: iserror ? colors.green_base : colors.red_base,
            fontFamily: 'Roboto',
            fontSize: 16),
      ),
      backgroundColor: iserror ? colors.green_smooth : colors.red_smooth,
    ),
  );
}

class AddGymInfo extends StatefulWidget {
  GymModel gym;
  File? imageFile;
  bool oldGym;
  List<Placelocation> gymsaddress;
  AddGymInfo(
      {Key? key,
      required this.gym,
      required this.imageFile,
      required this.oldGym,
      required this.gymsaddress})
      : super(key: key);
  static const routeName = '/sawedd';
  @override

  // static const routeNamed = '/EditADD';
  _AddGymInfoState createState() => _AddGymInfoState();
}

class _AddGymInfoState extends State<AddGymInfo> {
  var uid = FirebaseAuth.instance.currentUser!.uid;

  bool? isMen;
  void whatIsGender() {
    if (widget.gym.gender == 'Men') {
      setState(() {
        isMen = true;
      });
    } else if (widget.gym.gender == 'Women') {
      setState(() {
        isMen = false;
      });
    }
  }

  Future image() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);
    setState(() {
      widget.imageFile = imageTemp;
      widget.oldGym = false;
    });
  }

  final _form = GlobalKey<FormState>();

  var _isInit = true;

  @override
  Widget build(BuildContext context) {
    final Gym = Provider.of<Gyms>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Add Gym',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: colors.blue_base,
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
              height: 480,
              width: 390,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _form,
                    child: ListView(
                      padding: EdgeInsets.all(10),
                      children: [
                        Text(
                          'Gym Information',
                          style:
                              TextStyle(fontSize: 30, color: colors.blue_base),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            maxLength: 20,
                            initialValue: widget.gym.name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: colors.black100),
                              ),
                            ),
                            onChanged: (value) {
                              widget.gym.name = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Please Write the Name of the Gym';
                              if (value.length <= 2) return 'Name is Too Short';
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLength: 256,
                          initialValue: widget.gym.description,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: colors.black100),
                            ),
                          ),
                          maxLines: 3,
                          onChanged: (value) {
                            widget.gym.description = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please Write the Description of your Gym';
                            if (value.length <= 10)
                              return 'Description is Too Short';
                          },
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              //is man?
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // isMen = true;
                                    widget.gym.gender = 'Men';
                                    print(widget.gym.gender);
                                  });
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.male,
                                        size: 30,
                                        color: widget.gym.gender == 'Men'
                                            ? colors.iconscolor
                                            : colors.hinttext,
                                      ),
                                      Text(
                                        "Men",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roborto',
                                          color: widget.gym.gender == 'Men'
                                              ? colors.iconscolor
                                              : colors.hinttext,
                                          fontWeight: widget.gym.gender == 'Men'
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // is woman?
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    //  isMen = false;
                                    widget.gym.gender = 'Women';
                                    print(widget.gym.gender);
                                  });
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.female,
                                        size: 30,
                                        color: widget.gym.gender == 'Men'
                                            ? colors.hinttext
                                            : colors.iconscolor,
                                      ),
                                      Text(
                                        "Women",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roborto',
                                          color: widget.gym.gender == 'Men'
                                              ? colors.hinttext
                                              : colors.iconscolor,
                                          fontWeight: widget.gym.gender == 'Men'
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colors.blue_base),
                                child: FlatButton.icon(
                                  icon: Icon(Icons.camera_alt_rounded,
                                      color: Colors.white),
                                  onPressed: () {
                                    image();
                                  },
                                  label: Text(
                                    "Choose a Picture for Your Gym",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 300,
                              height: 300,
                              child: widget.imageFile != null
                                  ? Image.file(
                                      widget.imageFile!,
                                      fit: BoxFit.contain,
                                    )
                                  : widget.oldGym
                                      ? Container(
                                          width: 299.0,
                                          height: 149.0,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      widget.gym.imageURL ??
                                                          ''),
                                                  fit: BoxFit.contain)),
                                        )
                                      : Image.asset(
                                          "assets/images/gyms_home_logo.png",
                                          fit: BoxFit.contain),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                  color: colors.blue_base),
              child: FlatButton(
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_form.currentState!.validate() &&
                      (widget.imageFile != null ||
                          widget.gym.imageURL!.isNotEmpty)) {
                    List<File?> imgs = [];
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageInput(
                              gymsaddress: widget.gymsaddress,
                              imagesFile: imgs,
                              gym: widget.gym,
                              imageFile: widget.imageFile,
                            )));
                    print(widget.gym.name);
                    print(widget.gym.description);
                    print(widget.imageFile);
                  } else {
                    if (widget.gym.imageURL!.isEmpty &&
                        widget.imageFile == null)
                      message(context, false,
                          "Please Choose a Picture for Your Gym");
                  }
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
                  style: TextStyle(color: colors.blue_base),
                ),
                onPressed: () {
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
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
