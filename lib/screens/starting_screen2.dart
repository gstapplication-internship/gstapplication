import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:gst/screens/login_screen.dart';

class StartingScreen2 extends StatefulWidget {
  @override
  _StartingScreen2State createState() => _StartingScreen2State();
}

class _StartingScreen2State extends State<StartingScreen2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 2),
          () =>
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>LoginScreen())
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.all(20),
        // color: Color.fromRGBO(47, 91, 145, 0),
        //color: Hexcolor("#355c91"),

        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black,
            Hexcolor("#305c91"),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Image(
          image: AssetImage("assets/gs.png"),
          width: MediaQuery.of(context).size.width-20,
          height: 800,
          //fit: BoxFit.fill,
        ),
      ),
    );
  }
}
