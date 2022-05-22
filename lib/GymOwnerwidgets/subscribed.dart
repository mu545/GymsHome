import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';

import '../models/PaymentModel.dart';
import '../widgets/subscribeCard.dart';

class Subscribed extends StatefulWidget {
  final String gymid;
  const Subscribed({required this.gymid, Key? key}) : super(key: key);

  @override
  State<Subscribed> createState() => _SubscribedState();
}

class _SubscribedState extends State<Subscribed> {
  List<PaymentModel> subsList = [];

  Future? _getDataSub() => FirebaseFirestore.instance
      .collection('Payments')
      .where('gymId', isEqualTo: widget.gymid)
      .get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscribed',
          style: TextStyle(color: Colors.white, fontFamily: 'Epilogue'),
        ),
        backgroundColor: colors.blue_base,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _getDataSub(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                subsList.clear();
                snapshot.data.docs.forEach((element) {
                  subsList.add(PaymentModel.fromJson(element.data()));
                });

                if (subsList.isEmpty)
                  return SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: Text(
                          'No one subscribed this gym',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        controller: ScrollController(keepScrollOffset: true),
                        shrinkWrap: true,
                        itemCount: subsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SubscribeCard(sub: subsList[index]);
                        },
                      )
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}

// class Bill {
// //  String? customerId;
//   Timestamp? date;
//   Timestamp? expirationDate;
//   String? duration;
//   // String? gymId;
//   double? price;
//   // String? ownerId;
//   String? gymName;
//   String? customername;

//   Bill(
//       {this.customername,
//       this.gymName,
//       this.price,
//       this.duration,
//       this.expirationDate,
//       this.date});
// }
