import 'package:flutter/material.dart';

void main() => runApp(MyNavApp());

class Routes {
  static const String firstPage = '/';
  static const String secondPage = '/second';
  static const String thirdPage = '/second/third';
}

class MyNavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      routes: {
//AQxc  Routes.firstPage: (BuildContext context) => FirstPage(),
        Routes.secondPage: (BuildContext context) => SecondPage(),
        Routes.thirdPage: (BuildContext context) => ThirdPage(),
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(child: Text('My Page!')),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('title'),

//label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('title'),

//label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('title'),
//label: 'School2',
          ),
        ],
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
      ),
      drawer: Drawer(
// through the options in the drawer if there isn't enough vertical
// space to fit everything.
        child: ListView(
// Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              title: Text('Page 2'),
              onTap: () {
// Update the state of the app
// ...
// Then close the drawer
                Navigator.pushNamed(context, Routes.secondPage);
              },
            ),
            ListTile(
              title: Text('Page 3'),
              onTap: () {
// Update the state of the app
// ...
// Then close the drawer
                Navigator.pushNamed(context, Routes.thirdPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Center(
        child: FlatButton(
          child: Text(
            'second Page',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.thirdPage);
          },
        ),
      )),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Center(
        child: FlatButton(
          child: Text(
            'Third Page',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.popUntil(
                context, (r) => r.settings.name == Routes.firstPage);
          },
        ),
      )),
    );
  }
}

/////////////////////////////////////////////////////
// <Widget>[
// FAQ('test0', 'content0').faqAlert(context),
// Container(
// padding: const EdgeInsets.all(15),
// child: TextButton(
// child: Text(
// "Viewing all previous hits",
// ),
// onPressed: () {
// _showDialog(context, 'title', 'content');
// },
// ),
// color: mainColour.withAlpha(200),
// ),
// Container(
// padding: const EdgeInsets.all(15),
// child: TextButton(
// child: Text(
// "Changing your Password",
// ),
// onPressed: () {},
// ),
// color: mainColour.withAlpha(300),
// ),
// Container(
// padding: const EdgeInsets.all(15),
// child: TextButton(
// child: Text(
// "Getting involved with CREDO",
// ),
// onPressed: () {},
// ),
// color: mainColour.withAlpha(400),
// ),
// Container(
// padding: const EdgeInsets.all(15),
// child: TextButton(
// child: Text(
// "More FAQ",
// ),
// onPressed: () {},
// ),
// color: mainColour.withAlpha(500),
// ),
// Container(
// padding: const EdgeInsets.all(15),
// child: TextButton(
// child: Text(
// "More FAQ",
// ),
// onPressed: () {},
// ),
// color: mainColour.withAlpha(600),
// ),
// ],
