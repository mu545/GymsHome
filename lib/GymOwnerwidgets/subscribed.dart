import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';

class Subscribed extends StatefulWidget {
  final String gymid;
  const Subscribed({required this.gymid, Key? key}) : super(key: key);

  @override
  State<Subscribed> createState() => _SubscribedState();
}

class _SubscribedState extends State<Subscribed> {
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
          Container(
            width: double.infinity,
            child: Text(
              'Subscriptions',
              style: TextStyle(color: colors.blue_base, fontSize: 23),
            ),
          ),
          Divider(thickness: 2),
          FutureBuilder(
            future: _getDataSub(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                // subsList.clear();
                snapshot.data.docs.forEach((element) {
                  // subsList.add(PaymentModel.fromJson(element.data()));
                });

                // if (subsList.isEmpty)
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Text(
                    'You have not subscribed to a gym yet',
                    textAlign: TextAlign.center,
                  ),
                );

                // return Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Column(
                //     children: [
                //       ListView.builder(
                //         controller: ScrollController(keepScrollOffset: true),
                //         shrinkWrap: true,
                //         itemCount: subsList.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           return SubscribeCard(sub: subsList[index]);
                //         },
                //       )
                //     ],
                //   ),
                // );
              } else
                return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
