import 'dart:io';
import 'package:gst/filescreen/file_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gst/filescreen/simple_table.dart' as simple;
import 'package:gst/filescreen/custom_data_table.dart' as custom;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart'as path;
import 'package:hexcolor/hexcolor.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => new _FilePickerDemoState();
}

File file;
String contents;
String name;
FirebaseStorage _storage= FirebaseStorage.instance;
StorageUploadTask _upload;

class _FilePickerDemoState extends State<FilePickerDemo> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _isButtonDisable = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black,
                  Hexcolor("#305c91"),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Column(
                children: <Widget>[

                  Container(
                    color: Hexcolor("#305c91"),
                    margin: EdgeInsets.only(top: 30),
                    child:Image(
                      image: AssetImage("assets/file.png"),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: RaisedButton(
                      child: Text(
                        "SELECT FILE",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {
                        openFileExplorer(context);
                      },
                      color: Hexcolor("#305c91"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "SHOW",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () {

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyApp()));

                    },
                    color: Hexcolor("#305c91"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  RaisedButton(
                    child: Text(
                      "UPLOAD",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () async {
                      name=path.basename(file.path);
                      _upload = _storage.ref().child(name).putFile(file);
                      await _upload.onComplete;
                      print("success");
                      _uploaded();

                    },
                    color: Hexcolor("#305c91"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
//              RaisedButton(
//                child: Text("EDIT "),
//                onPressed: () {
//                  Navigator.of(context).push(MaterialPageRoute(
//                      builder: (context) => custom.CustomDataTable()));
//                },
//              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openFileExplorer(BuildContext context) async {
    try {
      file = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      print(file.path);
      contents = await file.readAsString();
      simple.dis(contents);
      custom.dis(contents);
      if (file != null) {
        _isButtonDisable = false;
//        showAlertDialog2(context);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }
  _uploaded() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Hexcolor("#305c91"),
                  ),
                ),
              ),
              Text(
                "file uploaded successfully",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        );
      },
    );
  }
}
