import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymhome/GymOwnerwidgets/facilities.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/GymOwnerwidgets/ownerhome.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/checkbox.dart';
import 'package:gymhome/widgets/imageinput.dart';
import 'package:gymhome/widgets/newhome.dart';

import 'package:provider/provider.dart';

class AddGymInfo extends StatefulWidget {
  static const routeName = '/sawedd';
  @override
  // static const routeNamed = '/EditADD';
  _AddGymInfoState createState() => _AddGymInfoState();
}

class _AddGymInfoState extends State<AddGymInfo> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Gyms(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
    location: '',
    facilites: '',
  );

  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  var _isInit = true;
  bool _isLoading = false;

  @override
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _Saved() async {
    final Validate = _form.currentState!.validate();

    _form.currentState!.save();
    Provider.of<Gymsitems>(context, listen: false).addGyms(_editedProduct);

    Navigator.of(context).pushNamed(ImageInput.routenamed);
  }

  @override
  Widget build(BuildContext context) {
    final Gym = Provider.of<Gyms>(context);
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
              height: 400,
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
                          style: TextStyle(fontSize: 30, color: Colors.blue),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            initialValue: _initValues['title'],
                            decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide a value.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Gyms(
                                title: value!,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageUrl: _editedProduct.imageUrl,
                                id: _editedProduct.id,
                                location: _editedProduct.location,
                                facilites: _editedProduct.facilites,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: _initValues['description'],
                          decoration: InputDecoration(
                            hintText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 7,
                          focusNode: _descriptionFocusNode,
                          keyboardType: TextInputType.multiline,
                          onSaved: (value) {
                            _editedProduct = Gyms(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: value!,
                              imageUrl: _editedProduct.imageUrl,
                              id: _editedProduct.id,
                              location: _editedProduct.location,
                              facilites: _editedProduct.facilites,
                            );
                          },
                        ),
                        Column(
                          children: [],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.blue),
              child: FlatButton(
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _Saved,
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
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
