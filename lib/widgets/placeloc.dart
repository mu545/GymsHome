import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation extends StatefulWidget {
  @override
  _PlaceLocationState createState() => _PlaceLocationState();
}

class _PlaceLocationState extends State<PlaceLocation> {
  //  String ?  _previewImageUrl  ;
  GoogleMapController? googleMapController;
  var latitude = 0.0;
  var longitude = 0.0;
  Future<LatLng> getlocation() async {
    final locdata = await Location().getLocation();
    // latitude = locdata.latitude!;
    // longitude = locdata.longitude!;
    // print(locdata.latitude);
    // print(locdata.longitude);
    return LatLng(locdata.latitude!, locdata.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        // mapToolbarEnabled: true,
        // myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController c) {
          // to control the camera position of the map
          googleMapController = c;
        },
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(20.5937, 78.9629),
        ),
      ),
    );
  }
}
