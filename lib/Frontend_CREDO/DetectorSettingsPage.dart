import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class detectorSettingsPage extends StatefulWidget {
  @override
  DetectorSettingsPageState createState() {
    return DetectorSettingsPageState();
  }
}

class DetectorSettingsPageState extends State<detectorSettingsPage> {
  bool isSwitched = false;
  String dropdownValue = 'Medium';
  double sliderRating = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detector settings '),
      ),
      body: Container(
          child: ListView(
        padding: EdgeInsets.all(32),
        children: [
          ListTile(
            title: (Text('Camera resolution')),
            subtitle: (DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Low', 'Medium', 'High']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
          ),
          ListTile(
              title: Text('Detect only when charging'),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },
                activeColor: Color(0xffee7355),
                activeTrackColor: Color(0x80ee7355),
              )),
          ListTile(
            title: Text('Auto Off'),
            subtitle: Slider(
              value: sliderRating,
              min: 0,
              max: 100,
              divisions: 10,
              label: sliderRating.round().toString(),
              activeColor: Color(0xffee7355),
              //activeTrackColor: Color(0x80ee7355),
              onChanged: (double value) {
                setState(() {
                  sliderRating = value;
                });
              },
            ),
          ),
        ],
      )),
    );
  }
}
