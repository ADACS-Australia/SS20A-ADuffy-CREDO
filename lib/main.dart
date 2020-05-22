import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:sensors/sensors.dart';
import 'OldDetectorFragment.dart';

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
  CameraController _controller;
  bool _cameraInitialized = false;
  Position _currentPosition;

  // init state and tell it to initialize camera

  @override
  void initState() {
    super.initState();
    //accelerometerEvents.listen((AccelerometerEvent event) {
    //print(event);
    //});

    // _initializeCamera(); // initializes to early if we want it on button pressed
    // does this mean i do not need to initialize camera again in the streaming void function ?
  }

// defiine init camera  as async function (use void)
  void _initializeCamera() async {
    if (_cameraInitialized == false) {
      List<CameraDescription> cameras = await availableCameras();
      int black_threshhold = 40;

      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      _controller.initialize().then((_) async {
        _cameraInitialized = true;
        int frame_number = 0;
        // start camera stream
        await _controller // needs CameraInfo checks for orientation etc.
            .startImageStream((CameraImage image) =>
                processImageFrame(image, frame_number, black_threshhold));
      });
    } else {
      //_controller.stopImageStream();
      dispose();
      _cameraInitialized = false;
    }

    setState(() {
      _cameraInitialized;
    });
  }

  // dispose and deactivate camera
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // on and Off button
  // _onOffSwitch(_cameraState) {
  //   if (_cameraState == false) {
  //     _initializeCamera();
  //   } else {
  //     dispose();
  //   }
  // }

  // Get course location
  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        //print(_currentPosition);
      });
    }).catchError((e) {
      print(e);
    });
  }

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
              onPressed: _getCurrentLocation,
              child: const Text('Get Location', style: TextStyle(fontSize: 20)),
            ),
            Text("$_currentPosition"),
            RaisedButton(
              onPressed: _initializeCamera,
              child: const Text('START Image Stream',
                  style: TextStyle(fontSize: 20)),
            ),
            Text("$_cameraInitialized"),
          ],
        ),
      ),
    );
  }
}
