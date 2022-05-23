import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/main.dart';
import 'package:gymhome/models/PaymentModel.dart';
import 'package:intl/intl.dart';

class SubscribeCard extends StatefulWidget {
  PaymentModel sub;
  bool isCustomer;

  SubscribeCard({Key? key, required this.sub, required this.isCustomer})
      : super(key: key);

  @override
  State<SubscribeCard> createState() => _SubscribeCardState();
}

class _SubscribeCardState extends State<SubscribeCard> {
  void initState() {
    super.initState();
    setColor();
  }

  bool? isExpired;
  String getTime(Timestamp timestamp) {
    String time;
    int year = timestamp.toDate().year;
    int month = timestamp.toDate().month;
    int day = timestamp.toDate().day;
    time = DateFormat.yMMMMd().format(DateTime(year, month, day));

    return time;
  }

  setColor() {
    int year = widget.sub.expirationDate!.toDate().year;
    int month = widget.sub.expirationDate!.toDate().month;
    int day = widget.sub.expirationDate!.toDate().day;
    DateTime expire = DateTime(year, month, day);
    // expire = DateTime.parse('2022-06-01 01:00:00');
    print(expire);
    print(DateTime.now());
    if (DateTime.now().isAfter(expire)) {
      setState(() {
        isExpired = true;
      });
    } else {
      setState(() {
        isExpired = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: isExpired! ? Color.fromARGB(170, 255, 255, 255) : Colors.white,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: widget.isCustomer
                  ? Text(
                      'You have a subscription at ${widget.sub.gymName}',
                      style: TextStyle(
                          color: isExpired! ? colors.black60 : colors.blue_base,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Epilogue'),
                    )
                  : Text(
                      '${widget.sub.customerName} subscribed at your gym: ${widget.sub.gymName}',
                      style: TextStyle(
                          color: isExpired! ? colors.black60 : colors.blue_base,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Epilogue'),
                    ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Subscribed since: ',
                  style: TextStyle(
                      color: isExpired! ? colors.black60 : colors.green_base,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Epilogue'),
                ),
                Text(
                  getTime(widget.sub.date!),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Ends in: ',
                  style: TextStyle(
                      color: isExpired! ? colors.black60 : colors.red_base,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Epilogue'),
                ),
                Text(
                  getTime(widget.sub.expirationDate!),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Duration: ',
                  style: TextStyle(
                      color: isExpired! ? colors.black60 : colors.blue_base,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Epilogue'),
                ),
                Text(
                  widget.sub.duration ?? '',
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Price: ',
                  style: TextStyle(
                      color: isExpired! ? colors.black60 : colors.blue_base,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Epilogue'),
                ),
                Text(
                  "${widget.sub.price.toString()} SAR",
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Subscription ID: ',
                  style: TextStyle(
                      color: isExpired! ? colors.black60 : colors.blue_base,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Epilogue'),
                ),
                Text(
                  widget.sub.paymentID ?? '',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
