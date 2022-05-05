import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';

import 'package:gymhome/widgets/AddGym.dart';
import 'package:gymhome/widgets/edit.dart';
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
  List<String?> prices = [];
  RegExp numbers = RegExp(r'^[0-9]+\.?[0-9]*$');
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    prices.clear();
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
                                                widget.gym.priceOneDay != 0
                                            ? widget.gym.priceOneDay.toString()
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
                                        widget.gym.priceOneDay =
                                            double.parse(value);
                                      } else {
                                        widget.gym.priceOneDay = 0;
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
                                            widget.gym.priceOneMonth != 0
                                        ? widget.gym.priceOneMonth.toString()
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
                                        widget.gym.priceOneMonth =
                                            double.parse(value);
                                      } else {
                                        widget.gym.priceOneMonth = 0;
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
                                            widget.gym.priceThreeMonths != 0
                                        ? widget.gym.priceThreeMonths.toString()
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
                                        widget.gym.priceThreeMonths =
                                            double.parse(value);
                                      } else {
                                        widget.gym.priceThreeMonths = 0;
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
                                            widget.gym.priceSixMonths != 0
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
                  prices.clear();
                  if (_form.currentState!.validate()) {
                    if (widget.gym.priceOneDay == 0) {
                      prices.remove('One Day');
                    } else
                      prices.add('One Day');
                    if (widget.gym.priceOneMonth == 0) {
                      prices.remove('One Month');
                    } else
                      prices.add('One Month');
                    if (widget.gym.priceThreeMonths == 0) {
                      prices.remove('Three Months');
                    } else
                      prices.add('Three Months');
                    if (widget.gym.priceSixMonths == 0) {
                      prices.remove('Six Months');
                    } else
                      prices.add('Six Months');
                    if (widget.gym.priceOneYear == 0) {
                      prices.remove('One Year');
                    } else
                      prices.add('One Year');
                    Provider.of<AddGymMethods>(context, listen: false)
                        .addGym(widget.gym, widget.imageFile,
                            widget.newGymImages, prices)
                        .whenComplete(() {
                      if (widget.gym.gymId == '') {
                        message(
                            context, true, 'Thank you, your gym has been sent');
                      } else {
                        message(context, true, 'Your gym has been updated');
                      }
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (widget.gym.gymId!.isNotEmpty) Navigator.pop(context);
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
