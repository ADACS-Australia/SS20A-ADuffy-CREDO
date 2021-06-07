import 'package:credo_transcript/utils/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetectorSettingsPage extends StatefulWidget {
  @override
  DetectorSettingsPageState createState() {
    return DetectorSettingsPageState();
  }
}

class DetectorSettingsPageState extends State<DetectorSettingsPage> {
  bool detectOnlyWhileCharging = false;
  String cameraResolution = 'Medium';
  double autoOffValue = 30;

  getPrefs() async {
    var _detectOnlyWhileCharging = await Prefs.getPrefBool(
        Prefs.DETECT_ONLY_WHILE_CHARGING,
        defaultValue: false);
    var _dropdownValue = await Prefs.getPrefString(Prefs.CAMERA_RESOLUTION,
        defaultValue: 'Medium');
    var _sliderRating =
        await Prefs.getPrefDouble(Prefs.AUTO_OFF, defaultValue: 30);

    setState(() {
      detectOnlyWhileCharging = _detectOnlyWhileCharging;
      cameraResolution = _dropdownValue;
      autoOffValue = _sliderRating;
    });
  }

  DetectorSettingsPageState() {
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detector settings '),
      ),
      body: Container(
          // would normally replace container with SingleChildScroll view but that breaks the page
          child: ListView(
        padding: EdgeInsets.all(32),
        children: [
          ListTile(
            title: (Text('Camera resolution')),
            subtitle: (DropdownButton<String>(
              value: cameraResolution,
              isExpanded: true,
              onChanged: (String? newValue) {
                Prefs.setPrefString(Prefs.CAMERA_RESOLUTION, newValue!);

                setState(() {
                  cameraResolution = newValue;
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
                value: detectOnlyWhileCharging,
                onChanged: (value) {
                  Prefs.setPrefBool(Prefs.DETECT_ONLY_WHILE_CHARGING, value);

                  setState(() {
                    detectOnlyWhileCharging = value;
                    print(detectOnlyWhileCharging);
                  });
                },
                activeColor: Color(0xffee7355),
                activeTrackColor: Color(0x80ee7355),
              )),
          ListTile(
            title: Text('Auto Off'),
            subtitle: Slider(
              value: autoOffValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: autoOffValue.round().toString(),
              activeColor: Color(0xffee7355),
              //activeTrackColor: Color(0x80ee7355),
              onChanged: (double value) {
                Prefs.setPrefDouble(Prefs.AUTO_OFF, value);

                setState(() {
                  autoOffValue = value;
                });
              },
            ),
          ),
        ],
      )),
    );
  }
}
