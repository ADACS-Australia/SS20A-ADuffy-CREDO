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
  Widget build(BuildContext context) {
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
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text(
                        "How to use CREDO Mobile?",
                      ),
                      onPressed: () {},
                    ),
                    color: mainColour.withAlpha(100),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextButton(
                      child: Text(
                        "Viewing all previous hits",
                      ),
                      onPressed: () {},
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
