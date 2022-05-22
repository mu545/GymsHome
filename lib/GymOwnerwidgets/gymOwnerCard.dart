import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:gymhome/models/GymModel.dart';
import '../Styles.dart';
import '../widgets/locationmap.dart';
import 'GymOwnerDescription.dart';

class GymCard extends StatefulWidget {
  List<Placelocation> gymsaddress;
  final GeoPoint userLocation;
  GymCard({
    Key? key,
    required this.userLocation,
    required this.gymsaddress,
    required this.gymInfo,
  }) : super(key: key);
  final GymModel gymInfo;

  @override
  State<GymCard> createState() => _GymCardState();
}

class _GymCardState extends State<GymCard> {
  String distance = 'Loading...';
  // GeoPoint? userLocation;

  @override
  void initState() {
    super.initState();
  }

  String getDistance() {
    return Placelocation.calculateDistance(
        widget.gymInfo.location!, widget.userLocation);
  }

  @override
  Widget build(BuildContext context) {
    // Placelocation.calculateDistance(gymInfo.location!)
    //     .then((value) => distance = value);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GymOwnerDescrption(
                  gym: widget.gymInfo,
                  gymsaddress: widget.gymsaddress,
                  //  userid: gymInfo.ownerId,
                )));
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => AddGymInfo(
        //           gym: gymInfo,
        //           imageFile: null,
        //           oldGym: true,
        //         )));
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.31,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(17, 66, 66, 66).withOpacity(0.25),
                  // offset: Offset(3, 3),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                      width: double.infinity,
                      height: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: Image.network(widget.gymInfo.imageURL ?? '',
                              fit: BoxFit.cover)),
                    ),
                    Positioned.fill(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        // height: MediaQuery.of(context).size.height,
                        // padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          // color: Color.fromARGB(110, 0, 0, 0),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(110, 0, 0, 0),
                                Color.fromARGB(90, 0, 0, 0),
                                Color.fromARGB(80, 0, 0, 0),
                              ]),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 3.0, left: 3),
                              child: Text(
                                widget.gymInfo.name!,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Positioned(
                    //   left: 15,
                    //   top: 20,
                    //   child: InkWell(
                    //     onTap: onfavoriteTap,
                    //     child: Icon(
                    //       isFavorite ? Icons.favorite : Icons.favorite_border,
                    //       size: 42,
                    //       color: isFavorite ? Colors.red : Colors.grey,
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   left: 0,
                    //   child: Container(
                    //     padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    //     decoration: BoxDecoration(
                    //         color: Colors.black.withOpacity(0.5),
                    //         borderRadius: BorderRadius.only(
                    //             topRight: Radius.circular(50))),
                    //     child: Text(
                    //       widget.gymInfo.name ?? '',
                    //       style: TextStyle(
                    //           fontSize: 32,
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ),

                    // ),
                  ],
                ),
              ),
              Container(
                // height: MediaQuery.of(context).size.height * 0.15,

                // height: 150,
                decoration: BoxDecoration(

                    // color: Colors.black12,
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 27, 27, 27)),
                        ),
                        Row(
                          children: [
                            Text(
                              ' ' + widget.gymInfo.avg_rate.toString(),
                              style: TextStyle(
                                  fontSize: 20, color: colors.textcolor),
                            ),
                            Icon(
                              Icons.star,
                              size: 45,
                              color: colors.yellow_base,
                            ),
                          ],
                        )
                      ],
                    ),
                    // SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.userLocation == null
                                  ? 'Loading'
                                  : getDistance(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: colors.textcolor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.directions_walk,
                              color: Color.fromARGB(174, 0, 0, 0),
                              size: 35,
                            )
                          ],
                        ),
                        ///////
                        widget.gymInfo.reviews == 0
                            ? Text('No reviews yet',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, color: colors.textcolor))
                            : Row(
                                children: [
                                  Text(
                                    "Based on ",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16, color: colors.textcolor),
                                  ),
                                  Text(widget.gymInfo.reviews.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: colors.textcolor)),
                                  Text(" reviews",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: colors.textcolor))
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
