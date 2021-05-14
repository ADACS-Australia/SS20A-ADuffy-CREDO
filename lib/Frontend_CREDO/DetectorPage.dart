import 'dart:ui';
import 'package:credo_transcript/AllSensorsHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

///we create an instance of all sensors helper here as well as
///write _initializeDetector as a function here as we do not want any other part of the code be able to access this function.
var helper = AllSensorsHelper();

class detectorPage extends StatefulWidget {
  //detectorPage({Key key}) : super(key: key);
  @override
  _detectorPageState createState() => new _detectorPageState();
}

class _detectorPageState extends State<detectorPage> {
  bool _detectorInitialized = false;
  var accelerometerValues;
  String fileContents = "No Data";
  String detectorOnOrOff = 'OFF';
  String startOrStop = 'START';
  String cameraCoveredText = 'YES';

  ///we create an instance of all sensors helper here as well as
  ///write _initializeDetector as a function here as we do not want any other part of the code be able to access this function.
  var helper = AllSensorsHelper();

  _initializeDetector() {
    if (_detectorInitialized == false) {
      print('Detector being switched on');

      helper.startAllSensors();

      helper.cameraCoveredChange((bCovered) => setState(() {
        cameraCoveredText = bCovered ? "YES" : "NO";
      }));

      setState(() {
        _detectorInitialized = true;
        detectorOnOrOff = 'ON';
        startOrStop = 'STOP';
      });
    } else {
      print('Turning off detector');

      helper.stopAllSensors();
      setState(() {
        _detectorInitialized = false;
        detectorOnOrOff = 'OFF';
        startOrStop = 'START';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      'Username',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('TeamName')
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
            ),
            Text(
              detectorOnOrOff,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            Padding(padding: EdgeInsets.all(2)),
            Text(
              'Detector Status',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
                onPressed: _initializeDetector,
                child: Container(
                  width: 500,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "$startOrStop DETECTOR",
                    style: TextStyle(
                      fontSize: 20.0,
                      //fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
            Text(
              'Camera Covered: ' + cameraCoveredText,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('-'),
                      Text(
                        'Start',
                        style: TextStyle(color: Color(0x80CEC8C8)),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    width: 50,
                    thickness: 2,
                    color: Color(0x80CEC8C8),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('-'),
                      Text(
                        'Working Time',
                        style: TextStyle(color: Color(0x80CEC8C8)),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    width: 50,
                    thickness: 2,
                    color: Color(0x80CEC8C8),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('-'),
                      Text(
                        'Hit',
                        style: TextStyle(color: Color(0x80CEC8C8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Detections last 10 days: ",
                  style: TextStyle(color: Color(0x80CEC8C8)),
                ),
                Text(
                  '0',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(15)),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [Text('Size:'), Text('Working:')],
                ),
                TableRow(
                  children: [Text('Total Frames:'), Text('Good:')],
                ),
                TableRow(
                  children: [Text('Bright:'), Text('Blacks:')],
                ),
                TableRow(
                  children: [Text('Charging:'), Text('Battery:')],
                ),
              ],
            )
          ]),
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
    );
  }

  void buttonPressed() {}
}
