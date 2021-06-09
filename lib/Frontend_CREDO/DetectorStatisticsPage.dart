import 'package:flutter/material.dart';
import 'package:credo_transcript/utils/prefs.dart';
import 'package:flutter/cupertino.dart';

class DetectorStatisticsPage extends StatefulWidget {
  @override
  DetectorStatisticsPageState createState() {
    return DetectorStatisticsPageState();
  }
}

class DetectorStatisticsPageState extends State<DetectorStatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detector Statistics '),
        ),
        body: SingleChildScrollView(
          child: dividedRow(),
        ));
  }
}

Widget dividedRow() {
  return Column(
    children: [
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
                  'Total Detections',
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
                  'Frames Taken',
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
                  'Runtime',
                  style: TextStyle(color: Color(0x80CEC8C8)),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
