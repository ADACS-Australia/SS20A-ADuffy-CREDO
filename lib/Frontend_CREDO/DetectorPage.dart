import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class detectorPage extends StatefulWidget {
  var globals;

  detectorPage(globals) {
    this.globals = globals;
  }

  @override
  _detectorPageState createState() => new _detectorPageState(globals);
}

class _detectorPageState extends State<detectorPage> {
  var accelerometerValues;
  String fileContents = "No Data";
  String detectorOnOrOff = 'OFF';
  String startOrStop = 'START';
  String cameraCoveredText = 'YES';
  String chargeText = "Unknown";
  int batteryPercentage = 0;
  var globals;

  // Create a duration to handle checking the battery percentage
  var _batteryCheckDuration = Duration(seconds: 30);

  updateBatteryLevel(timer) async {
    int _batteryLevel = await globals.battery.batteryLevel;
    if (mounted) {
      setState(() {
        batteryPercentage = _batteryLevel;
      });
    }
  }

  updateDetectorText() {
    setState(() {
      detectorOnOrOff = globals.detectorHelper.running() ? 'ON' : 'OFF';
      startOrStop = globals.detectorHelper.running() ? 'STOP' : 'START';
    });
  }

  _detectorPageState(globals) {
    this.globals = globals;

    globals.onCameraCoveredChange = (bCovered) => {
          if (mounted)
            {
              setState(() {
                cameraCoveredText = bCovered ? "YES" : "NO";
              })
            }
        };

    globals.onChargeStateChange = (state) => {
          if (mounted)
            {
              setState(() {
                chargeText = state;
              })
            }
        };

    Timer.periodic(_batteryCheckDuration, updateBatteryLevel);
    updateBatteryLevel(null);

    detectorOnOrOff = globals.detectorHelper.running() ? 'ON' : 'OFF';
    startOrStop = globals.detectorHelper.running() ? 'STOP' : 'START';
    cameraCoveredText = globals.isCameraCovered ? "YES" : "NO";
    chargeText = globals.chargeState;
  }

  _toggleDetector() {
    globals.detectorHelper.toggleAllSensors();
    updateDetectorText();
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
                onPressed: _toggleDetector,
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
                  children: [
                    Text('Charging: ' + chargeText),
                    Text('Battery: ' + batteryPercentage.toString() + "%")
                  ],
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
