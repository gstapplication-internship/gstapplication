import 'package:flutter/material.dart';
import 'package:gst/screens/starting_screen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gst/screens/starting_screen2.dart';
//import '';

void main(){
  runApp(MyGst());
}

class MyGst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return StreamBuilder(
      stream: _auth.onAuthStateChanged,
      builder: (ctx, AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.hasData) {

          FirebaseUser user = snapshot.data;

          if(user != null) {
            return StartingScreen1();
          } else {
            return StartingScreen2();
          }
        }

        return StartingScreen2();

      },
    );
  }
}


