
import 'package:credo_transcript/AllSensorsHelper.dart';
import 'package:credo_transcript/network/repository.dart';
import 'package:flutter/material.dart';
import 'FileUtils.dart';

Future<void> main() async {
  runApp(
    CredoHome(),
  );
}

/// Flutter operates int he form of widgets that get build
/// and if they have states update their states when prompted.
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
  bool _detectorInitialized = false;
  var accelerometerValues;
  String fileContents = "No Data";
  CredoRepository _credoRepository = CredoRepository();

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


  /// this block describes the layout that the user can interact with.
  /// the scaffold ca have a body with in turn can have one or more children (depends on the type)
  /// to update things within the scaffold use setState (inherited f rom StatefullWidget) in functions to alert the app that changes are preselnt.
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
              child:
                  const Text('Toggle Detector', style: TextStyle(fontSize: 20)),
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
            RaisedButton(
              child: Text("Login by Username"),
              onPressed: (){
                 _credoRepository.requestLogin("eman", "ehab");
              },
            ),
            RaisedButton(
              child: Text("Login by Email"),
              onPressed: (){
                 _credoRepository.requestLogin("emanehab99@yahoo.com", "XQsHsm2q7HzevhH");
              },
            ),
          ],
        ),
      ),
    );
  }
}
