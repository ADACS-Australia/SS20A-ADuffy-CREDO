import 'package:credo_transcript/AllSensorsHelper.dart';
import 'package:flutter/material.dart';
import 'package:credo_transcript/CameraHelper.dart';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:sensors/sensors.dart';
import 'OldDetectorFragment.dart';
import 'LocationHelper.dart';
import 'AccelerometerHelper.dart';

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

  // init state and tell it to initialize camera

  @override
  void initState() {
    super.initState();
  }

  ///AllSensorsHelper
  ///makes instances of all streams
  ///startall(),stopall()

// defiine init camera  as async function (use void)
  //void _initializeCamera() async {
  //  /// make into class
  //  /// CameraHelper class
  //  /// init() --> get cameras,
  //  /// tooglecamera --> check cameraState to turn off and on
  //  if (_cameraInitialized == false) {
  //    List<CameraDescription> cameras = await availableCameras();
  //    int black_threshhold = 40;
//
  //    _controller = CameraController(cameras[0], ResolutionPreset.medium);
  //    _controller.initialize().then((_) async {
  //      _cameraInitialized = true;
  //      int frame_number = 0;
  //      // start camera stream
  //      await _controller // needs CameraInfo checks for orientation etc.
  //          .startImageStream((CameraImage image) =>
  //              processImageFrame(image, frame_number, black_threshhold));
  //    });
  //  } else {
  //    //_controller.stopImageStream();
//
  //    dispose();
  //    _cameraInitialized = false;
  //  }
//
  //  setState(() {
  //    _cameraInitialized;
  //  });
  //}
//
  //// dispose and deactivate camera
  //@override
  //void dispose() {
  //  _controller.dispose();
  //  super.dispose();
  //}

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
