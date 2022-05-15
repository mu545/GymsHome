import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymhome/GymOwnerwidgets/EditGymInfo.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/profile_model.dart';
import 'package:gymhome/models/user.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/locationmap.dart';

import '../provider/customer.dart';

class GymCardCustomer extends StatefulWidget {
  final String userid;
  final GymModel gymInfo;
  final String price;
  // final bool fav;
  // final bool compare;
  const GymCardCustomer(
      {Key? key,
      required this.gymInfo,
      required this.userid,
      // required this.compare,
      // required this.fav,
      required this.price})
      : super(key: key);

  @override
  State<GymCardCustomer> createState() => _GymCardCustomerState();
}

class _GymCardCustomerState extends State<GymCardCustomer> {
  GeoPoint userLocation = GeoPoint(0, 0);
  List<dynamic> listFav = [];
  List<dynamic> listCompare = [];
  String distance = 'Loading...';
  // bool? isFav = false;
  // bool? isCompare = false;

  // bool iconClr(type) {
  //   list.clear();
  //   var user = FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(widget.userid)
  //       .get();
  //   user.then((value) {
  //     list = value[type];
  //     print(list);

  //     if (list.contains(widget.gymInfo.gymId)) {
  //       if (type == 'Likes') {
  //         isFav = true;
  //         return isFav;
  //       } else {
  //         isCompare = true;
  //         return isCompare;
  //       }

  //       // return isFav;
  //     } else {
  //       if (type == 'Likes') {
  //         isFav = false;
  //         return isFav;
  //       } else {
  //         isCompare = false;
  //         return isCompare;
  //       }
  //     }
  //   });

  //   if (type == "Likes") {
  //     return isFav;
  //   } else {
  //     return isCompare;
  //   }
  // }

  // bool colorsCompare() {
  //   list.clear();
  //   var user = FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(widget.userid)
  //       .get();
  //   user.then((value) {
  //     list = value['compare'];
  //     print(list);
  //     if (list.contains(widget.gymInfo.gymId)) {
  //       setState(() {
  //         isCompare = true;
  //       });
  //       // return isFav;
  //     } else {
  //       setState(() {
  //         isCompare = false;
  //       });
  //       //  return isFav;
  //     }
  //   });

  //   return isCompare;
  //   //return false;
  // }

  getListFav() {
    listFav.clear();
    var gym = FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gymInfo.gymId)
        .get();
    print(widget.gymInfo.gymId);
    gym.then((value) {
      listFav = value['Likes'];
      handelFavs(listFav);
      // print(list);
    });
    setState(() {});
  }

  getListCompare() {
    listCompare.clear();
    var gym = FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gymInfo.gymId)
        .get();
    print(widget.gymInfo.gymId);
    gym.then((value) {
      listCompare = value['compare'];
      handelCompare(listCompare);
      // print(list);
    });
    setState(() {});
  }

  handelCompare(List list) {
    if (list.contains(widget.userid)) {
      list.remove(widget.userid);
      print('REMOVED FROM LIST $list');
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(widget.gymInfo.gymId)
          .update({
        'compare': FieldValue.arrayRemove([widget.userid])
      });
    } else {
      list.add(widget.userid);
      print('ADD TO LIST $list');
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(widget.gymInfo.gymId)
          .update({
        'compare': FieldValue.arrayUnion([widget.userid])
      });
    }
    setState(() {
      widget.gymInfo.compare = list;
    });
  }

  handelFavs(List list) {
    if (list.contains(widget.userid)) {
      list.remove(widget.userid);
      print('REMOVED FROM LIST $list');
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(widget.gymInfo.gymId)
          .update({
        'Likes': FieldValue.arrayRemove([widget.userid])
      });
    } else {
      list.add(widget.userid);
      print('ADD TO LIST $list');
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(widget.gymInfo.gymId)
          .update({
        'Likes': FieldValue.arrayUnion([widget.userid])
      });
    }
    setState(() {
      widget.gymInfo.Likes = list;
    });
  }

  String price = '';
  String showPrice() {
    switch (widget.price) {
      case 'One Day':
        setState(() {
          price = widget.gymInfo.priceOneDay.toString() + ' SAR';
        });
        return price;
      case 'One Month':
        setState(() {
          price = widget.gymInfo.priceOneMonth.toString() + ' SAR';
        });
        return price;
      case 'Three Months':
        setState(() {
          price = widget.gymInfo.priceThreeMonths.toString() + ' SAR';
        });
        return price;
      case 'Six Months':
        setState(() {
          price = widget.gymInfo.priceSixMonths.toString() + ' SAR';
        });
        return price;
      case 'One Year':
        setState(() {
          price = widget.gymInfo.priceOneYear.toString() + ' SAR';
        });
        return price;
      default:
        return '';
    }
  }

  void getDistance() async {
    // final Position locdata = await Geolocator.getCurrentPosition();
    // GeoPoint userLocation = GeoPoint(locdata.latitude, locdata.longitude);
    // var _dis = distance;
    // if (userLocation.latitude != 0 && userLocation.longitude != 0)
    final _dis =
        Placelocation.calculateDistance(widget.gymInfo.location!, userLocation);
    // if (mounted)
    setState(() {
      distance = _dis;
    });
    // print('dis$distance');
  }

  @override
  void initState() {
    // TODO: implement initState

    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        userLocation = GeoPoint(value.latitude, value.longitude);
      });
    }).whenComplete(() => getDistance());
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   // do something
    //   getDistance();
    // });
    super.initState();
  }

  // @override
  // void dispose() {
  //   setState(() {
  //     distance='';
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // getDistance();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   // do something
    getDistance();
    // });
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GymDescrption(
                  price: widget.price,
                  gym: widget.gymInfo,
                  userid: widget.userid,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            // width: MediaQuery.of(context).size.width * 0.5,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                // color: Color.fromARGB(255, 255, 255, 255),
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
                      //FAVORITE
                      Positioned(
                        left: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            getListFav();
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              // color: Color.fromARGB(83, 0, 0, 0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(21),
                              ),
                            ),
                            child: Icon(
                              widget.gymInfo.Likes!.contains(widget.userid)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 30,
                              color:
                                  widget.gymInfo.Likes!.contains(widget.userid)
                                      ? Colors.red
                                      : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   left: 10,
                      //   top: 10,
                      //   child: InkWell(
                      //     onTap: () {
                      //       getListFav();
                      //     },
                      //     child: Icon(
                      //       Icons.favorite_border,
                      //       size: 43,
                      //       color: Color.fromARGB(34, 255, 255, 255),
                      //     ),
                      //   ),
                      // ),
                      // COMPARE
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            getListCompare();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Color.fromARGB(84, 0, 0, 0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(21),
                              ),
                            ),
                            child: Icon(
                              Icons.compare_arrows,
                              size: 35,
                              color: widget.gymInfo.compare!
                                      .contains(widget.userid)
                                  ? colors.green_base
                                  : Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
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
                            showPrice(),
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
                                distance,
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
                                          fontSize: 16,
                                          color: colors.textcolor),
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
      ),
    );
  }
}
