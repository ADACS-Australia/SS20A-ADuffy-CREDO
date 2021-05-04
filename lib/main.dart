import 'package:credo_transcript/AllSensorsHelper.dart';
import 'package:flutter/material.dart';
import 'FileUtils.dart';
import 'Frontend_CREDO/AccountsPage.dart';
import 'Frontend_CREDO/HomePage.dart';
import 'Frontend_CREDO/DetectorPage.dart';
import 'Frontend_CREDO/SciencePagePage.dart';
import 'Frontend_CREDO/HelpPage.dart';
import 'Frontend_CREDO/AccountsPage.dart';
import 'Frontend_CREDO/DetectorSettingsPage.dart';
import 'Frontend_CREDO/themeSettings.dart';

Future<void> main() async {
  runApp(
    CredoHome(),
  );
}

// initialise routes for navigation
class Routes {
  static const String accountsPage = '/AccountsPage';
  static const String detectorSettingsPage = '/detectorsettings';
  static const String detectorStatisticsPage = '/detectorStatistics';
}

/// Flutter operates int he form of widgets that get build
/// and if they have states update their states when prompted.
class CredoHome extends StatelessWidget {
  static const String _title = 'CREDO';

  bool loggedin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: credoTheme(),
      title: _title,
      home: MyHomePage(),
      routes: {
        // Routes.detectorStatisticsPage: (BuildContext context) => detector,
        Routes.accountsPage: (BuildContext context) => AccountsPage(),
        Routes.detectorSettingsPage: (BuildContext context) =>
            detectorSettingsPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        //body that will build the app when opened
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
        title: 'CREDO Login Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _detectorInitialized = false;
  var accelerometerValues;
  String fileContents = "No Data";

  // This is the class that handles all interactions with CREDO API's
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
  /// to update things within the scaffold use setState (inherited from StatefullWidget) in functions to alert the app that changes are present.
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    homePage,
    detectorPage(),
    sciencePage,
    helpPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// to update things within the scaffold use setState (inherited f rom StatefullWidget) in functions to alert the app that changes are preselnt.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREDO Sample'),
        titleTextStyle: optionStyle,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Column(
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text('username')
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account'),
              onTap: () {
                Navigator.pushNamed(context, Routes.accountsPage);
              },
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('Detector Settings'),
              onTap: () {
                Navigator.pushNamed(context, Routes.detectorSettingsPage);
              },
            ),
            ListTile(
              leading: Icon(Icons.leaderboard),
              title: Text('Detector Statistics'),
              onTap: () {
                Navigator.pushNamed(context, Routes.detectorStatisticsPage);
              },
            ),
            Text(fileContents),
            RaisedButton(
              child: Text("Logout"),
              onPressed: () {
                _credoRepository.clearPrefs();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flare),
            label: 'Detector',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science_outlined),
            label: 'Science',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline_rounded),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.white,
        //unselectedItemColor: Colors.black54,
        //backgroundColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Application Login Screen
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // login & password field values
  String _login;
  String _password;

  // Class the handles all interaction with CREDO API's
  CredoRepository _credoRepository = CredoRepository();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {
    super.initState();
    //initialise class to load system and device info
    _credoRepository.init();
  }

  @override
  Widget build(BuildContext context) {
    //Email/username field
    final emailField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Username/Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        onChanged: (value) {
          _login = value;
        });

    //Password Field
    final passwordField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        onChanged: (value) {
          _password = value;
        });
    //Login Field
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // send login request to endpoint
          _credoRepository.requestLogin(_login, _password);
          // navigate to detection screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyHomePage(title: 'CREDO Demo Home Page')),
          );
        },
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
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
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
