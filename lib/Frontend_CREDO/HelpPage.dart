import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget helpPage1 = helpPage();

/// This is the stateful widget that the main application instantiates.
class helpPage extends StatefulWidget {
  //helpPage({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<helpPage> {
  int _index = 0;
  Color mainColour = Color(0xffee7355);

  Map faqmap = {
    'title1': 'content1',
    'title2': 'content2',
    'title3': 'content3',
    'title4': 'content4',
  };

  Widget build(BuildContext context) {
    List faqlist = makeFAQlist(faqmap);
    return Container(
        padding: const EdgeInsets.all(32),
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverToBoxAdapter(
              /// TO DO: get a real image to pu in as header
              child: Image(image: AssetImage('assets/images/credo_logo.png')),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'CREDO FAQ',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
                textScaleFactor: 1.5,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: <Widget>[
                  FAQ('test0', 'content0').faqAlert(context),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextButton(
                      child: Text(
                        "Viewing all previous hits",
                      ),
                      onPressed: () {
                        _showDialog(context, 'title', 'content');
                      },
                    ),
                    color: mainColour.withAlpha(200),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextButton(
                      child: Text(
                        "Changing your Password",
                      ),
                      onPressed: () {},
                    ),
                    color: mainColour.withAlpha(300),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextButton(
                      child: Text(
                        "Getting involved with CREDO",
                      ),
                      onPressed: () {},
                    ),
                    color: mainColour.withAlpha(400),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextButton(
                      child: Text(
                        "More FAQ",
                      ),
                      onPressed: () {},
                    ),
                    color: mainColour.withAlpha(500),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextButton(
                      child: Text(
                        "More FAQ",
                      ),
                      onPressed: () {},
                    ),
                    color: mainColour.withAlpha(600),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

void _showDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new TextButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class FAQ {
  String title = '';
  String content = '';

  FAQ(this.title, this.content);

  Widget faqAlert(BuildContext context) {
    return Container(
      color: Color(0xffee7355),
      padding: const EdgeInsets.all(15),
      child: TextButton(
        child: Text(title),
        onPressed: () {
          _showDialog(context, title, content);
        },
      ),
    );
  }
}

makeFAQlist(Map map) {
  List faqlist = [];
  map.forEach((key, value) => faqlist.add(FAQ(key, value)));
  return faqlist;
}
