/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'dart:ui';
import 'themeSettings.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'DetectorPage.dart';
import 'SciencePagePage.dart';
import 'HelpPage.dart';
import 'AccountsPage.dart';
import 'DetectorSettingsPage.dart';

void main() => runApp(MyApp());

class Routes {
  static const String accountsPage = '/AccountsPage';
  static const String detectorSettingsPage = '/detectorsettings';
  static const String detectorStatisticsPage = '/detectorStatistics';
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'CREDO';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: credoTheme(),
      title: _title,
      home: MyStatefulWidget(),
      routes: {
        // Routes.detectorStatisticsPage: (BuildContext context) => detector,
        Routes.accountsPage: (BuildContext context) => AccountsPage(),
        Routes.detectorSettingsPage: (BuildContext context) =>
            detectorSettingsPage(),
      },
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
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
