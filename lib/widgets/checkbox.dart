import 'package:flutter/material.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:provider/provider.dart';


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final gym = Provider.of<Gyms>(context) ;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
       
        setState(() {
           gym.poolstatus() ;

          isChecked = value!;
        });
        
      },
    );
  }
}
