import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/customer.dart';
import 'package:gymhome/widgets/customer_list.dart';

class CustomerTile extends StatelessWidget {
  //const CustomerTile({Key? key}) : super(key: key);
  final Customer customer;

  CustomerTile({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: colors.black100,
            ),
            title: Text(customer.name),
          ),
        ));
  }
}
