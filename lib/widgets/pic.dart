import 'package:flutter/material.dart';
import 'package:gymhome/widgets/help.dart';
import 'package:gymhome/widgets/imageinput.dart';
import 'package:gymhome/widgets/placeloc.dart';

import 'dart:io';

import 'package:provider/provider.dart';

class Addplace extends StatefulWidget {
  static const routeName = '/addplaces';
  @override
  _AddplaceState createState() => _AddplaceState();
}

class _AddplaceState extends State<Addplace> {
  final _textcon = TextEditingController();

  File? _imagesave;

  void _selectedimage(File Imagefile) {
    _imagesave = Imagefile;
  }

  void _savedplace() {
    Provider.of<great>(context, listen: false).add(_textcon.text, _imagesave!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _textcon,
                    ),
                  ),
                  //             ImageInput(_selectedimage),
                  SizedBox(
                    height: 10,
                  ),
                  // PlaceLocation()
                ],
              ),
            ),
          ),
          // Text('User Input'),
          RaisedButton.icon(
            onPressed: _savedplace,
            icon: Icon(Icons.add),
            label: Text('Add places'),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.yellow,
          )
        ],
      ),
    );
  }
}
