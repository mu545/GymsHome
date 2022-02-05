import 'package:flutter/material.dart';
import 'package:gymhome/authintactions/stripe.dart';

import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  @override
  static const routeName = '/pay';
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeServices.init();
  }

  void payNow() async {
    //the amount must be transformed to cents
    var response =
        await StripeServices.payNowHandler(amount: '1000', currency: 'USD');
    print('response message ${response.message}');
  }

  @override
  Widget build(BuildContext context) {
    // final productdata = Provider.of<Products>(context);
    // final productdas = Provider.of<Product>(context);
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          payNow();
        },
        child: Text('33'),
      )),
    );
  }
}
