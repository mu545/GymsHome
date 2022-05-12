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
  GeoPoint? userLocation;
  List<dynamic> listFav = [];
  List<dynamic> listCompare = [];
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

  String distance = 'Loading...';
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
    final _dis = await Placelocation.calculateDistance(
        widget.gymInfo.location!, userLocation!);
    if (mounted)
      setState(() {
        distance = _dis;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        userLocation = GeoPoint(value.latitude, value.longitude);
      });
    }).whenComplete(() => getDistance());
    // list.clear();
    // var gym = FirebaseFirestore.instance
    //     .collection('gyms')
    //     .doc(widget.gymInfo.gymId)
    //     .get();
    // print(widget.gymInfo.gymId);
    // gym.then((value) {
    //   list = value['Likes'];

    //   print(list);
    // });
    // isFav = widget.fav;
    // isCompare = widget.compare;
    // getDistance();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    getDistance();
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
                            child: Image.network(widget.gymInfo.imageURL ?? '',
                                fit: BoxFit.cover)),
                      ),
                      //FAVORITE
                      Positioned(
                        left: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            getListFav();
                          },
                          child: Icon(
                            widget.gymInfo.Likes!.contains(widget.userid)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 42,
                            color: widget.gymInfo.Likes!.contains(widget.userid)
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            getListFav();
                          },
                          child: Icon(
                            Icons.favorite_border,
                            size: 43,
                            color: Color.fromARGB(35, 0, 0, 0),
                          ),
                        ),
                      ),
                      // COMPARE
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            getListCompare();
                          },
                          child: Icon(
                            Icons.compare_arrows,
                            size: 42,
                            color:
                                widget.gymInfo.compare!.contains(widget.userid)
                                    ? colors.green_base
                                    : colors.black100,
                          ),
                        ),
                      ),
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
                            showPrice(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Text(
                                ' ' + widget.gymInfo.avg_rate.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
                          ///////
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
      ),
    );
  }
}
