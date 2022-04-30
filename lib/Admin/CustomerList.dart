import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/profile_model.dart';

class CustomerList extends StatefulWidget {
  CustomerList({Key? key, required this.user}) : super(key: key);
  ProfileModel user;
  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      child: Row(children: [
        Container(
          margin: EdgeInsets.all(5),
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(widget.user.userImage ?? ''),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Tooltip(
                message: widget.user.userName,
                child: Container(
                  //     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: widget.user.userName!.length <= 10
                      ? Text(
                          widget.user.userName ?? '',
                          style: TextStyle(
                              fontFamily: 'Epilouge',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(widget.user.userName!.replaceRange(
                          10, widget.user.userName!.length, '..')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Tooltip(
                message: widget.user.email,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: widget.user.email!.length <= 20
                      ? Text(widget.user.email ?? '')
                      : Text(widget.user.email!
                          .replaceRange(10, widget.user.email!.length, '..')),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {},
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Text(
                'Contact',
                style: TextStyle(color: colors.blue_base),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {},
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Text(
                'Ban',
                style: TextStyle(color: colors.red_base),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
