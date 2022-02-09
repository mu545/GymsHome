import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymhome/widgets/welcome.dart';

class resetpassword extends StatefulWidget {
  const resetpassword({Key? key}) : super(key: key);

  @override
  _resetpasswordState createState() => _resetpasswordState();
}

class _resetpasswordState extends State<resetpassword> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: 200,
          padding: EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 5),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reset password",
                    style: TextStyle(
                        fontFamily: 'Epilogue',
                        fontSize: 18,
                        color: colors.blue_base),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => welcome()));
                      Navigator.of(context).pop();
                    },
                    child:
                        Icon(Icons.cancel_outlined, color: colors.iconscolor),
                    // child: Text(
                    //   "back",
                    //   style: TextStyle(
                    //     fontFamily: 'Epilogue',
                    //     fontSize: 16,
                    //     color: colors.iconscolor,
                    //   ),
                    // ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.blue_base),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Enter your registered email ",
                    hintStyle: TextStyle(
                      color: colors.hinttext,
                    ),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: colors.blue_base,
                      onPrimary: colors.blue_smooth,
                      minimumSize: Size(250, 40)),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.

                    resetpass();

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future resetpass() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      message = 'Check your email';
    } on FirebaseAuthException catch (e) {
      message = e.code;
      if (message == 'unknown') message = 'enter correct email';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
              color: message == 'Check your email'
                  ? colors.red_base
                  : Colors.white,
              fontFamily: 'Roboto',
              fontSize: 16),
        ),
        backgroundColor: message == 'Check your email'
            ? colors.blue_smooth
            : colors.red_base,
      ),
    );
  }
}
