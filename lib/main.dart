
import 'package:credo_transcript/AllSensorsHelper.dart';
import 'package:credo_transcript/network/repository.dart';
import 'package:credo_transcript/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'FileUtils.dart';

Future<void> main() async {
 
  String savedTokin = await Prefs.getPref(Prefs.USER_TOKEN);
  bool loggedin = savedTokin != null;
  runApp(
    CredoHome(loggedin: loggedin,),
  );
}

/// Flutter operates int he form of widgets that get build
/// and if they have states update their states when prompted.
class CredoHome extends StatelessWidget {
  CredoHome({Key key, this.loggedin}): super(key: key);

  final bool loggedin;

  @override
  Widget build(BuildContext context) {

    dynamic home; 
    if(loggedin != null){ 
      home = MyHomePage(title: 'CREDO Demo Home Page',);
    }
    else{
      home = LoginPage(
        title: 'CREDO Login Page',
      );
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //body that will build the app when opened
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(
      //   title: 'CREDO Demo Home Page',
      // ),
      // home: LoginPage(
      //   title: 'CREDO Login Page',
      // ),
      home: home,
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
            // RaisedButton(
            //   child: Text("Login by Username"),
            //   onPressed: (){
            //      _credoRepository.requestLogin("eman", "ehab");
            //   },
            // ),
            // RaisedButton(
            //   child: Text("Login by Email"),
            //   onPressed: (){
            //      _credoRepository.requestLogin("emanehab99@yahoo.com", "XQsHsm2q7HzevhH");
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

      String _login;
      String _password;

      CredoRepository _credoRepository = CredoRepository();
      TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

      @override
      Widget build(BuildContext context) {

        final emailField = TextField(
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Username/Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          onChanged: (value){
            _login = value;
          }
        );
        final passwordField = TextField(
          obscureText: true,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          onChanged: (value){
            _password = value;
          }
        );
        final loginButon = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xff01A0C7),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () { _credoRepository.requestLogin(_login, _password);},
            child: Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );

        return Scaffold(
          body: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }