import 'dart:async';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymhome/models/GymModel.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../GymOwnerwidgets/gymprice.dart';
import '../models/user.dart';
import 'locationmap.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Customermap extends StatefulWidget {
  GymModel gym;
  // bool gender;

  Customermap({
    Key? key,
    // required this.gender,
    required this.gym,
  }) : super(key: key);
  @override
  _CustomermapState createState() => _CustomermapState();
}

class _CustomermapState extends State<Customermap> {
  GoogleMapController? googleMapController;
  // Position? _currentlocation;
  BitmapDescriptor? markericon;
  // BitmapDescriptor? womanMarker;

  Set<Marker> _markers = Set();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Permission.location.request();

    setGendricons();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.gym.name!,
            style: TextStyle(color: Colors.white, fontFamily: "Epilogue"),
          ),
          backgroundColor: colors.blue_base),
      body: Stack(children: [
        GoogleMap(
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          onMapCreated: (_mapController) {
            googleMapController = _mapController;

            _onCreate().whenComplete(() {
              setState(() {
                _isLoading = false;
              });
            });
          },
          markers: Set<Marker>.of(_markers),
          initialCameraPosition: CameraPosition(
            target: LatLng(
                widget.gym.location!.latitude, widget.gym.location!.longitude),
            zoom: 7,
          ),
        ),

        // load and get user location
        if (_isLoading)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: colors.loadback,
            child: Center(
                child: CircularProgressIndicator(
              color: colors.blue_base,
            )),
          ),
        if (!_isLoading)
          Positioned(
            bottom: screensize.height / 12,
            left: screensize.width / 4,
            right: screensize.width / 4,
            child: ElevatedButton(
              // style: ba:colors.blue_base,
              onPressed: () => MapsLauncher.launchCoordinates(
                widget.gym.location!.latitude,
                widget.gym.location!.longitude,
              ),
              style: ElevatedButton.styleFrom(primary: colors.blue_base),
              child: Text('Open in Google Map'),
            ),
          ),
        if (!_isLoading)
          Positioned(
            top: screensize.height / 50,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _userlocation().whenComplete(() {
                    setState(() {
                      _isLoading = false;
                    });
                  });
                },
                child: Icon(
                  Icons.my_location,
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
        // ElevatedButton(
        //   onPressed: () => MapsLauncher.launchQuery('destination'),
        //   child: Text('LAUNCH QUERY'),
        // ),
      ]),
    );
  }

  Future<void> _onCreate() async {
    googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(widget.gym.location!.latitude, widget.gym.location!.longitude),
        13));
    addGymLocation(
        LatLng(widget.gym.location!.latitude, widget.gym.location!.longitude),
        widget.gym.gymId!);
  }

  Future<void> _userlocation() async {
    final Position locdata = await Geolocator.getCurrentPosition();

    // _currentlocation = locdata;

    googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(locdata.latitude, locdata.longitude), 14));
  }
  //   addGymLocation(
  //       LatLng(_currentlocation!.latitude, _currentlocation!.longitude),
  //       widget.gym.gymId!);
  // }

  addGymLocation(LatLng latLng, String gymid) {
    // if (gymid != null)
    // _markers.removeWhere((element) => element.markerId == MarkerId(gymid));
    _markers.add(Marker(
      markerId: MarkerId(gymid),
      position: latLng,
      draggable: false,
      infoWindow: InfoWindow(
        // popup info
        title: widget.gym.name,
        snippet: widget.gym.gender,
      ),
      // icon: menMarker!,
      icon: markericon!,
    ));
    // setState(() {});
    // widget.gym.location = GeoPoint(latLng.latitude, latLng.longitude);
  }

  // getGymsLocation() {
  //   for (var gymlocation in widget.gymsaddress) {
  //     LatLng _location = LatLng(gymlocation.latiitude, gymlocation.longtitude);
  //     _markers.add(Marker(
  //       markerId: MarkerId(gymlocation.gymid),
  //       position: _location,
  //       draggable: false,
  //       infoWindow: InfoWindow(
  //         // popup info
  //         title: gymlocation.address,
  //         snippet: gymlocation.gender,
  //       ),
  //       icon: getMarkericon(gymlocation),
  //     ));
  //   }
  // }

  Future<void> setGendricons() async {
    var icon;
    if (widget.gym.gender == 'Men') {
      icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'assets/images/men_marker.png');
      setState(() {
        markericon = icon;
      });
    } else {
      icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'assets/images/woman_marker.png');
      setState(() {
        markericon = icon;
      });
    }
  }

  // BitmapDescriptor getMarkericon(Placelocation gymlocation) {
  //   if (gymlocation.gymid == widget.gym.gymId)
  //     return BitmapDescriptor.defaultMarker;
  //   if (gymlocation.gender == 'Men')
  //     return menMarker!;
  //   else
  //     return womanMarker!;
  // }

  // void _liveLocation(GoogleMapController _cntlr) {
  //   print('_onMapCreated');
  //   googleMapController = _cntlr;
  //   _location.onLocationChanged.listen((l) {
  //     googleMapController!.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 18),
  //       ),
  //     );
  //   });
  // }

}
