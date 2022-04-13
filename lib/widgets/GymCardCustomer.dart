import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/EditGymInfo.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/widgets/gymdescrption.dart';

import '../provider/customer.dart';

class GymCardCustomer extends StatelessWidget {
  final String userid;
  final GymModel gymInfo;
  const GymCardCustomer({Key? key, required this.gymInfo, required this.userid
      //required this.name,
      // required this.priceSixMonths,
      // required this.price,
      //  required this.imageURL,
      //this.onfavoriteTap,
      })
      : super(key: key);

  //final bool isFavorite;
  //final String name;
  // final double price;
//  final String imageURL;
  //final VoidCallback? onfavoriteTap;
  // final String gymId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GymDescrption(
                  gym: gymInfo,
                  userid: userid,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Image.network(gymInfo.imageURL ?? '',
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
                            gymInfo.name ?? '',
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
                      color: Colors.black12,
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
                            gymInfo.priceOndDay.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            gymInfo.location ?? '',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Based on 320 reviews",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "50 Km",
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
