import 'dart:ui';
import 'package:credo_transcript/AllSensorsHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class detectorPage extends StatefulWidget {
  //detectorPage({Key key}) : super(key: key);
  @override
  _detectorPageState createState() => new _detectorPageState();
}

class _detectorPageState extends State<detectorPage> {
  bool _detectorInitialized = false;
  var accelerometerValues;
  String fileContents = "No Data";

  @override
  void initState() {
    super.initState();
  }

  ///we create an instance of all sensors helper here as well as
  ///write _initializeDetector as a function here as we do not want any other part of the code be able to access this function.
  var helper = AllSensorsHelper();

  _initializeDetector() {
    if (_detectorInitialized == false) {
      helper.startAllSensors();

      _detectorInitialized = true;
    } else {
      helper.stopAllSensors();

      _detectorInitialized = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.science_outlined),
                  new Padding(
                    padding: const EdgeInsets.all(24.0),
                  ),
                  new ElevatedButton(
                      key: null,
                      onPressed: buttonPressed,
                      child: new Text(
                        "Detector Status: OFF",
                        style: new TextStyle(
                          fontSize: 20.0,

                          fontWeight: FontWeight.w500,
                          //fontFamily: "Roboto"
                        ),
                      )),
                  new Padding(
                    padding: const EdgeInsets.all(24.0),
                  ),
                  new Text(
                    "Spaceholder text for any stats we might want to display",
                  ),
                ])
          ]),
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
    );
  }

  void buttonPressed() {}
}
