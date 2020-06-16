import 'package:credo_transcript/AllSensorsHelper.dart';
import 'package:flutter/material.dart';
import 'package:credo_transcript/CameraHelper.dart';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'FileUtils.dart';

Future<void> main() async {
  runApp(
    CredoHome(),
  );
}

class CredoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //body that will build the app when opened
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'CREDO Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //CameraController _controller;
  bool _cameraInitialized = false;
  Position _currentPosition;
  var accelerometerValues;
  String fileContents = "No Data";

  // init state and tell it to initialize camera

  @override
  void initState() {
    super.initState();
  }

  var helper = AllSensorsHelper();
  //var cameraHelper = CameraHelper();
  Stopwatch stopwatch = new Stopwatch();

  _initializeDetector() {
    if (_cameraInitialized == false) {
      helper.startAllSensors();
      stopwatch.start();
      _cameraInitialized = true;
    } else {
      helper.stopAllSensors();
      stopwatch.stop();
      _cameraInitialized = false;
    }
    //print(SensorHelper().accelerometerState);
  }

  /// make new button with the sole function to get and update accelerometerValues

  // makes the layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Placeholder for image',
            ),
            RaisedButton(
              onPressed: _initializeDetector,
              child: const Text('Get Location', style: TextStyle(fontSize: 20)),
            ),
            Text("$accelerometerValues"),
            RaisedButton(
              child: Text("Read From File"),
              onPressed: () {
                FileUtils.readFromFile().then((contents) {
                  print(contents);
                  setState(() {
                    fileContents = contents;
                  });
                });
              },
            ),
            Text(fileContents),

            //RaisedButton(
            //  onPressed: print('object'), //cameraHelper.toggleCamera(),
            //  child: const Text('START Image Stream',
            //      style: TextStyle(fontSize: 20)),
            //),
            //Text("_ means can't read"),
          ],
        ),
      ),
    );
  }
}
