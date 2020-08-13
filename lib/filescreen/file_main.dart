import 'package:flutter/material.dart';
//import 'file_picker_demo.dart';
import 'package:gst/filescreen/simple_table.dart';

import 'custom.dart';

String contents;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Table Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => RootPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/customData': (context) => CustomDataTable(),
      },
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("SALES REPORT")),
          backgroundColor: Colors.indigo,
        ),
        body: SimpleTable(),
      ),
    );
  }
}
