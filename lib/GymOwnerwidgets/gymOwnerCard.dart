import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymhome/models/GymModel.dart';
import '../Styles.dart';
import '../widgets/locationmap.dart';
import 'GymOwnerDescription.dart';

class GymCard extends StatefulWidget {
  List<Placelocation> gymsaddress;
  GymCard({
    Key? key,
    required this.gymsaddress,
    required this.gymInfo,
  }) : super(key: key);
  final GymModel gymInfo;

  @override
  State<GymCard> createState() => _GymCardState();
}

class _GymCardState extends State<GymCard> {
  String distance = 'Loading...';
  GeoPoint? userLocation;

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        userLocation = GeoPoint(value.latitude, value.longitude);
      });
    }).whenComplete(() => getDistance());
  }

  void getDistance() async {
    // final Position locdata = await Geolocator.getCurrentPosition();
    // GeoPoint userLocation = GeoPoint(locdata.latitude, locdata.longitude);
    final _dis = await Placelocation.calculateDistance(
        widget.gymInfo.location!, userLocation!);
    if (mounted)
      setState(() {
        distance = _dis;
      });

    // print(distance);
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
          height: MediaQuery.of(context).size.height * 0.35,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Color(0xff3d4343),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  offset: Offset(3, 3),
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50))),
                        child: Text(
                          widget.gymInfo.name ?? '',
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff48484a),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          //    price ??
                          '',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              '' + widget.gymInfo.avg_rate.toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              distance,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.directions_walk,
                              color: Colors.white,
                            )
                          ],
                        ),
                        Text(
                          widget.gymInfo.reviews == 0
                              ? 'No reviews yet'
                              : "Based on " +
                                  widget.gymInfo.reviews.toString() +
                                  " reviews",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
