import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PlaceLocation extends StatefulWidget {
  @override
  _PlaceLocationState createState() => _PlaceLocationState();
}

class _PlaceLocationState extends State<PlaceLocation> {
  //  String ?  _previewImageUrl  ;
  GoogleMapController? googleMapController;
  Position? _userlocation;
  final Set<Marker> markers = new Set();

  Future<void> _getlocation() async {
    Permission.location.request();
    final Position locdata = await Geolocator.getCurrentPosition();
    // latitude = locdata.latitude!;
    // longitude = locdata.longitude!;
    setState(() {
      _userlocation = locdata;
    });
    googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_userlocation!.latitude, _userlocation!.longitude), 14));
    print(_userlocation);
    // print(locdata.longitude);
    // return LatLng(locdata.latitude!, locdata.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          mapToolbarEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController c) {
            // to control the camera position of the map
            googleMapController = c;
          },
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _getlocation,
              child: Icon(
                Icons.map,
                color: Colors.white,
                size: 30,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                primary: colors.blue_base, // <-- Button color
                // onPrimary: Colors.red, // <-- Splash color
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
