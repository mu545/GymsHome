import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymhome/models/customer.dart';
import 'package:provider/provider.dart';
import 'customer_tile.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<List<Customer>>(context);

    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        return CustomerTile(customer: customers[index]);
      },
    );
  }
}
