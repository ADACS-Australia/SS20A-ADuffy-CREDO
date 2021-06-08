import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class DetectorPage extends StatefulWidget {
  @override
  DetectorPageState createState() => new DetectorPageState();
}

class DetectorPageState extends State<DetectorPage> {
  var accelerometerValues;
  String fileContents = "No Data";
  String detectorOnOrOff = 'OFF';
  String startOrStop = 'START';
  String cameraCoveredText = 'YES';
  Color cameraCoveredColor = Colors.grey;
  String chargeText = "Unknown";
  int batteryPercentage = 0;
  String workingTimeText = '-';
  String hitCountText = '-';

  // Create a duration to handle checking the battery percentage
  var _batteryCheckDuration = Duration(seconds: 30);

  // Create a duration to handle second interval updates
  var _oneSecondDuration = Duration(seconds: 1);

  DetectorPageState() {
    globals.onCameraCoveredChange = (bCovered) => {
          if (mounted)
            {
              setState(() {
                cameraCoveredText = bCovered ? "YES" : "NO";
                cameraCoveredColor =
                    bCovered ? Colors.lightGreenAccent : Colors.redAccent;
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

    Timer.periodic(_oneSecondDuration, oneSecondTimer);

    detectorOnOrOff = globals.detectorHelper.running() ? 'ON' : 'OFF';
    startOrStop = globals.detectorHelper.running() ? 'STOP' : 'START';
    cameraCoveredText = globals.isCameraCovered ? "YES" : "NO";
    chargeText = globals.chargeState;
    cameraCoveredColor =
        globals.isCameraCovered ? Colors.lightGreenAccent : Colors.redAccent;
  }

  _toggleDetector() {
    globals.detectorHelper.toggleAllSensors();
    updateDetectorText();
    oneSecondTimer(null);
  }

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

  oneSecondTimer(timer) {
    if (!mounted) return;

    String _workingTimeText = '-';
    String _hitCountText = '-';
    if (globals.detectorHelper.running()) {
      var duration = DateTime.now().difference(globals.detectorStartTime);

      _workingTimeText = '${duration.inHours.toString().padLeft(2, '0')}:'
          '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
          '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

      _hitCountText = globals.detectorHits.toString();
    }

    setState(() {
      workingTimeText = _workingTimeText;
      hitCountText = _hitCountText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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

              Padding(padding: EdgeInsets.all(10)),
              RichText(
                text: TextSpan(text: 'Camera Covered: ', children: [
                  TextSpan(
                    text: "$cameraCoveredText",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: cameraCoveredColor),
                  ),
                ]),
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
                        Text(globals.detectorHelper.running()
                            ? new DateFormat("HH:mm")
                                .format(globals.detectorStartTime)
                            : '-'),
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
                        Text(workingTimeText),
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
                        Text(hitCountText),
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
              //Table(
              //  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //  children: [
              //    TableRow(
              //      children: [Text('Size:'), Text('Working:')],
              //    ),
              //    TableRow(
              //      children: [Text('Total Frames:'), Text('Good:')],
              //    ),
              //    TableRow(
              //      children: [Text('Bright:'), Text('Blacks:')],
              //    ),
              //    TableRow(
              //      children: [
              //        Text('Charging: ' + chargeText),
              //        Text('Battery: ' + batteryPercentage.toString() + "%")
              //      ],
              //    ),
              //  ],
              //)
            ]),
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
      ),
    );
  }

  void buttonPressed() {}
}
