// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gymhome/Styles.dart';
// import 'package:gymhome/widgets/locationmap.dart';

// import '../models/GymModel.dart';
// import 'GymCardCustomer.dart';

// class Sort extends StatelessWidget {
//   List<GymModel> gymsList;
//   String priceChoosed;
//   // int sortBy;
//   final String userid;
//   Sort(
//       {
//       // {required this.sortBy,
//       required this.priceChoosed,
//       required this.userid,
//       required this.gymsList,
//       key})
//       : super(key: key);

//   // bool selectedAss = false;
//   // Future<void> sortByLocation() async {
//   //   List<GymModel> gymsListSorted;
//   //   GeoPoint gym1;
//   //   double dis1;
//   //   GeoPoint gym2;
//   //   double dis2;
//   //   for (int i = 0; i < gymsList.length - 1; i++) {
//   //     for (int j = 0; j < gymsList.length - 1 - i; j++) {
//   //       gym1 = GeoPoint(
//   //           gymsList[j].location!.latitude, gymsList[j].location!.longitude);
//   //       gym2 = GeoPoint(gymsList[j + 1].location!.latitude,
//   //           gymsList[j + 1].location!.longitude);

//   //       dis1 = await Placelocation.distanceInKM(gym1);
//   //       dis2 = await Placelocation.distanceInKM(gym2);
//   //       if (dis1 > dis2) {
//   //         GymModel tmp = gymsList[j];
//   //         gymsList[j] = gymsList[j + 1];
//   //         gymsList[j + 1] = tmp;
//   //       }
//   //     }
//   //   }
//   //   gymsListSorted = gymsList;
//   //   print('list' +
//   //       gymsListSorted[0].location!.latitude.toString() +
//   //       '->' +
//   //       gymsListSorted[1].location!.latitude.toString());
//   //   // setState(() {});
//   //   // gymsListSorted = gymsList;
//   //   // return gymsListSorted;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               ListView.builder(
//                 controller: ScrollController(keepScrollOffset: true),
//                 shrinkWrap: true,
//                 itemCount: gymsList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return GymCardCustomer(
//                     userlocation: ,
//                     price: priceChoosed,
//                     gymInfo: gymsList[index],
//                     userid: userid,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // setDir() {}
// }
