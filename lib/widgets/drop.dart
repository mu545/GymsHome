import 'package:flutter/material.dart';
enum AuthMode { Customer, Owner }
class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<DropDown> {
  String dropdownValue = 'Customer';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 2,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Customer', 'GymOwner',]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
