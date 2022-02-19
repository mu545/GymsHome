import 'package:flutter/material.dart';
import 'package:location/location.dart';

class PlaceLocation extends StatefulWidget {
  @override
  _PlaceLocationState createState() => _PlaceLocationState();
}

class _PlaceLocationState extends State<PlaceLocation> {
  //  String ?  _previewImageUrl  ;
  Future<void> getlocation() async {
    final locdata = await Location().getLocation();

    print(locdata.latitude);
    print(locdata.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Image.network(
            '',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              onPressed: getlocation,
              icon: Icon(Icons.location_on),
              label: Text('Curent Location '),
              color: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Select on Map  '),
              color: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
