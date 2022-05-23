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

class PlaceLocation extends StatefulWidget {
  File? imageFile;
  List<File> newGymImages;
  GymModel gym;
  List<Placelocation> gymsaddress;
  PlaceLocation(
      {Key? key,
      required this.gymsaddress,
      required this.gym,
      required this.imageFile,
      required this.newGymImages})
      : super(key: key);
  @override
  _PlaceLocationState createState() => _PlaceLocationState();
}

class _PlaceLocationState extends State<PlaceLocation> {
  GoogleMapController? googleMapController;
  Position? _currentlocation;
  BitmapDescriptor? menMarker;
  BitmapDescriptor? womanMarker;

  Set<Marker> _markers = Set();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Permission.location.request();

    setGendricons().whenComplete(() {
      if (widget.gymsaddress.isNotEmpty) getGymsLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: screensize.height,
        width: screensize.width,
        child: Stack(children: [
          GoogleMap(
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (_mapController) {
              googleMapController = _mapController;

              if (widget.gym.location != null)
                _onCreate().whenComplete(() {
                  setState(() {
                    _isLoading = false;
                  });
                  AppUser.warning(context,
                      'Long press any where on the map to change gym location');
                });
              else
                _userlocation().whenComplete(() {
                  setState(() {
                    _isLoading = false;
                    AppUser.warning(context,
                        'Long press any where on the map to change gym location');
                  });
                });
            },
            onLongPress: (latlang) {
              addGymLocation(latlang, widget.gym.gymId!);
            },
            markers: Set<Marker>.of(_markers),
            initialCameraPosition: CameraPosition(
              target: LatLng(24.723505, 46.624889),
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
          if (!_isLoading)
            Positioned(
                bottom: screensize.height / 15,
                left: screensize.width / 12,
                right: screensize.width / 12,
                child: Column(
                  children: [
                    Container(
                      width: (screensize.width * 5) / 6,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colors.blue_base,
                      ),
                      child: ElevatedButton(
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Future.delayed(
                            Duration(milliseconds: 500),
                            () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GymPrice(
                                        gym: widget.gym,
                                        imageFile: widget.imageFile,
                                        newGymImages: widget.newGymImages,
                                      )));
                            },
                          );
                          AppUser.message(
                              context, true, 'Gym address has been seved');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: colors.blue_base,
                          onPrimary: colors.blue_smooth,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: colors.blue_base,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: (screensize.width * 5) / 6,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: ElevatedButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: colors.blue_base,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: colors.blue_smooth,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: colors.blue_base,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        // textColor: Theme.of(context).primaryColor,
                        // shape: RoundedRectangleBorder(
                        //     side: BorderSide(
                        //         color: colors.blue_base,
                        //         width: 1,
                        //         style: BorderStyle.solid),
                        //     borderRadius: BorderRadius.circular(50)),
                      ),
                    )
                  ],
                ))
        ]),
      ),
    );
  }

  Future<void> _onCreate() async {
    googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(widget.gym.location!.latitude, widget.gym.location!.longitude),
        17));
    addGymLocation(
        LatLng(widget.gym.location!.latitude, widget.gym.location!.longitude),
        widget.gym.gymId!);
  }

  Future<void> _userlocation() async {
    final Position locdata = await Geolocator.getCurrentPosition();

    _currentlocation = locdata;

    googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_currentlocation!.latitude, _currentlocation!.longitude), 17));

    addGymLocation(
        LatLng(_currentlocation!.latitude, _currentlocation!.longitude),
        widget.gym.gymId!);
  }

  addGymLocation(LatLng latLng, String gymid) {
    // if (gymid != null)
    _markers.removeWhere((element) => element.markerId == MarkerId(gymid));
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
      icon: BitmapDescriptor.defaultMarker,
    ));
    setState(() {});
    widget.gym.location = GeoPoint(latLng.latitude, latLng.longitude);
  }

  getGymsLocation() {
    for (var gymlocation in widget.gymsaddress) {
      LatLng _location = LatLng(gymlocation.latiitude, gymlocation.longtitude);
      _markers.add(Marker(
        markerId: MarkerId(gymlocation.gymid),
        position: _location,
        draggable: false,
        infoWindow: InfoWindow(
          // popup info
          title: gymlocation.address,
          snippet: gymlocation.gender,
        ),
        icon: getMarkericon(gymlocation),
      ));
    }
  }

  Future<void> setGendricons() async {
    menMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/men_marker.png');

    womanMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/woman_marker.png');
  }

  BitmapDescriptor getMarkericon(Placelocation gymlocation) {
    if (gymlocation.gymid == widget.gym.gymId)
      return BitmapDescriptor.defaultMarker;
    if (gymlocation.gender == 'Men')
      return menMarker!;
    else
      return womanMarker!;
  }

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
