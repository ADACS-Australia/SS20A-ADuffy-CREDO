import 'dart:ui';
import 'dart:convert';
import 'package:flutter/services.dart';
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
  List<Widget> faqlist = [];

  /// fetch json content
  Future<void> makeFAQlist(BuildContext context) async {
    if (faqlist.isEmpty) {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/json/FAQs.json");
      final Map jsonResult = json.decode(data);

      List<Widget> _faqlist = [];
      jsonResult.forEach(
          (key, value) => _faqlist.add(FAQ(key, value).faqAlert(context)));
      setState(() {
        faqlist = _faqlist;
      });
    }
  }

  Widget build(BuildContext context) {
    makeFAQlist(context);

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
                children: faqlist,
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
        title: new Text(
          title,
          style: TextStyle(color: Color(0xFF1B1B1B)),
        ),
        content: new Text(
          content,
          style: TextStyle(color: Color(0xFF1B1B1B)),
        ),
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

///loads the json file from assets to be read in and processed

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
