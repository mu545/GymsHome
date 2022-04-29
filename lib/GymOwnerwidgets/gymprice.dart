import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/AddGym.dart';
import 'package:provider/provider.dart';
import '../models/GymModel.dart';

class GymPrice extends StatefulWidget {
  GymModel gym;
  File? imageFile;
  List<File> newGymImages;
  static const routenames = '/srsss';
  GymPrice({
    Key? key,
    required this.newGymImages,
    required this.gym,
    required this.imageFile,
  }) : super(key: key);

  @override
  _AddGymState createState() => _AddGymState();
}

class _AddGymState extends State<GymPrice> {
  RegExp numbers = RegExp(r'^[0-9]+\.?[0-9]*$');
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: widget.gym.gymId == ''
                ? Text(
                    'Add Gym ',
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    'Edit Gym ',
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
            Form(
              key: _form,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 400,
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
                                'Price',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: colors.blue_base,
                                    fontFamily: 'Epilogue'),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue:
                                        widget.gym.gymId!.isNotEmpty &&
                                                widget.gym.priceOndDay != 0
                                            ? widget.gym.priceOndDay.toString()
                                            : "",
                                    decoration: InputDecoration(
                                      labelText: 'Price for one Day',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: colors.black100),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        widget.gym.priceSixMonths =
                                            double.parse(value);
                                      } else {
                                        widget.gym.priceSixMonths = 0;
                                      }
                                    },
                                    validator: (value) {
                                      if (!numbers.hasMatch(value.toString()) &&
                                          value.toString() != '') {
                                        return 'please enter digits only';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: widget
                                                .gym.gymId!.isNotEmpty &&
                                            widget.gym.priceOndMonth != 0
                                        ? widget.gym.priceOndMonth.toString()
                                        : "",
                                    decoration: InputDecoration(
                                      labelText: 'Price for one Month',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: colors.black100),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        widget.gym.priceOndMonth =
                                            double.parse(value);
                                      } else {
                                        widget.gym.priceOndMonth = 0;
                                      }
                                    },
                                    validator: (value) {
                                      if (!numbers.hasMatch(value.toString()) &&
                                          value.toString() != '') {
                                        return 'please enter digits only';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: widget
                                                .gym.gymId!.isNotEmpty &&
                                            widget.gym.priceThreeMonts != 0
                                        ? widget.gym.priceThreeMonts.toString()
                                        : "",
                                    decoration: InputDecoration(
                                      labelText: 'Price for Three Months',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: colors.black100),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        widget.gym.priceThreeMonts =
                                            double.parse(value);
                                      } else {
                                        widget.gym.priceThreeMonts = 0;
                                      }
                                    },
                                    validator: (value) {
                                      if (!numbers.hasMatch(value.toString()) &&
                                          value.toString() != '') {
                                        return 'please enter digits only';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: widget
                                                .gym.gymId!.isNotEmpty &&
                                            widget.gym.priceSixMonths
                                                    .toString() !=
                                                '0.0'
                                        ? widget.gym.priceSixMonths.toString()
                                        : "",
                                    decoration: InputDecoration(
                                      labelText: 'Price for Six Months',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: colors.black100),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        widget.gym.priceSixMonths =
                                            double.parse(value);
                                      } else {
                                        widget.gym.priceSixMonths = 0;
                                      }
                                    },
                                    validator: (value) {
                                      if (!numbers.hasMatch(value.toString()) &&
                                          value.toString() != '') {
                                        return 'please enter digits only';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue:
                                        widget.gym.gymId!.isNotEmpty &&
                                                widget.gym.priceOneYear != 0
                                            ? widget.gym.priceOneYear.toString()
                                            : "",
                                    decoration: InputDecoration(
                                      labelText: 'Price for one Year',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: colors.black100),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        widget.gym.priceOneYear =
                                            double.parse(value);
                                      } else {
                                        widget.gym.priceOneYear = 0;
                                      }
                                    },
                                    validator: (value) {
                                      if (!numbers.hasMatch(value.toString()) &&
                                          value.toString().isNotEmpty) {
                                        return 'please enter digits only';
                                      }
                                    },
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
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colors.blue_base),
              child: FlatButton(
                child: Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Provider.of<AddGymMethods>(context, listen: false).addGym(
                        widget.gym, widget.imageFile, widget.newGymImages);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
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
                  style: TextStyle(
                    color: colors.blue_base,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
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
            ),
          ],
        ),
      ),
    );
  }
}
