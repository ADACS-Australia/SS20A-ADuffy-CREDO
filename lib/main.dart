import 'package:flutter/material.dart';

import 'Frontend_CREDO/AccountsPage.dart';
import 'Frontend_CREDO/DetectorPage.dart';
import 'Frontend_CREDO/DetectorSettingsPage.dart';
import 'Frontend_CREDO/HelpPage.dart';
import 'Frontend_CREDO/HomePage.dart';
import 'Frontend_CREDO/SciencePagePage.dart';
import 'Frontend_CREDO/themeSettings.dart';
import 'Globals.dart';
import 'network/repository.dart';
import 'Frontend_CREDO/LoginPage.dart';

Globals globals = new Globals();

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

  // bool loggedin = false;

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
              DetectorSettingsPage(),
        });

    //home: LoginPage(
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _detectorInitialized = false;
  var accelerometerValues;
  String fileContents = "No Data";
  CredoRepository _credoRepository = CredoRepository();
  late final _loggedin;
  // This is the class that handles all interactions with CREDO API's
  

  @override
  void initState() {
    super.initState();    
    _credoRepository.init();
    _loggedin = _credoRepository.checkSavedLogin();
  }

  /// this block describes the layout that the user can interact with.
  /// the scaffold ca have a body with in turn can have one or more children (depends on the type)
  /// to update things within the scaffold use setState (inherited from StatefullWidget) in functions to alert the app that changes are present.
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    homePage,
    DetectorPage(),
    sciencePage,
    helpPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        initialData: false,
        future: _loggedin, 
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          Widget children = LoginPage();
          var _drawer;
          if(snapshot.connectionState == ConnectionState.done){
            if (snapshot.hasData) {
            print('has data ${snapshot.data}');
            if(snapshot.data == false){
              children = LoginPage();
            }
            else{
              children = _widgetOptions.elementAt(_selectedIndex);
              _drawer = Drawer(
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
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            print('error');
            children = LoginPage();//<Widget>[
          } else {
            print('Doesnt have data');
            children = LoginPage();//<Widget>[
          }
          }
          
          return Scaffold(
            appBar: AppBar(
                title: const Text('CREDO Sample'),
                titleTextStyle: optionStyle,
            ), 
            drawer: _drawer,
            body: children,
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
        );
      }
    }