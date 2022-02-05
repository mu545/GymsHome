import 'dart:html';

import 'package:flutter/material.dart';
//import icons
//import colors
import 'package:gymhome/Styles.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  _welcomeState createState() => _welcomeState();
}

enum AuthMode { Signup, Login }
AuthMode _authMode = AuthMode.Login;

class _welcomeState extends State<welcome> {
  bool isSignup = true;
  bool iscustomer = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/signup.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 75,
                    left: 20,
                  ),
                  color: Color.fromARGB(146, 71, 153, 183),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Welcom to",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 25,
                          ),
                          children: [
                            TextSpan(
                              text: " Gyms Home.",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "all gyms in one place",
                        style: TextStyle(
                          fontFamily: 'Epilogue',
                          fontSize: 14,
                          color: Color.fromARGB(255, 255, 208, 79),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 200,
            child: Container(
              padding: EdgeInsets.all(20),
              height: 400,
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignup = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: 'Epilogue',
                                  fontSize: 18,
                                  color: isSignup
                                      ? colors.black60
                                      : colors.black100),
                            ),
                            if (!isSignup)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 2,
                                width: 90,
                                color: colors.blue_base,
                              ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignup = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontFamily: 'Epilogue',
                                  fontSize: 18,
                                  color: isSignup
                                      ? colors.black100
                                      : colors.black60),
                            ),
                            if (isSignup)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 2,
                                width: 90,
                                color: colors.blue_base,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (isSignup)
                    signup()
                  else
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          textfield(false, true, "Your email"),
                          textfield(true, false, "Password"),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container signup() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(children: [
        textfield(false, true, "Your email"),
        textfield(true, false, "Password"),
        textfield(true, false, "confirm password"),
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
// is customer?

              GestureDetector(
                onTap: () {
                  setState(() {
                    iscustomer = true;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: iscustomer ? colors.blue_base : Colors.white,
                        border: Border.all(
                          width: 1,
                          color: colors.hinttext,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.person,
                        color: iscustomer
                            ? Color.fromARGB(255, 255, 255, 255)
                            : colors.hinttext,
                      ),
                    ),
                    Text(
                      "Customer",
                      style: TextStyle(
                        color: iscustomer ? colors.black60 : colors.hinttext,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                width: 30,
              ),

// is gym owner?
              GestureDetector(
                onTap: () {
                  setState(() {
                    iscustomer = false;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: iscustomer ? Colors.white : colors.blue_base,
                        border: Border.all(
                          width: 1,
                          color: colors.hinttext,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.person,
                        color: iscustomer
                            ? colors.hinttext
                            : Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Text(
                      "Gym owner",
                      style: TextStyle(
                        color: iscustomer ? colors.hinttext : colors.black60,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
//submit botton
        Container(
          height: 40,
          width: 200,
          decoration: BoxDecoration(
            color: colors.blue_base,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isSignup ? "Sign Up" : "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget textfield(bool ispassword, bool isemail, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        obscureText: ispassword,
        keyboardType: isemail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.blue_base),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
          hintStyle: TextStyle(
            color: colors.hinttext,
          ),
        ),
      ),
    );
  }
}
