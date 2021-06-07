import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homePage = SingleChildScrollView(
    child: Container(
  padding: const EdgeInsets.all(32),
  //child: Center(
  child: Column(
    children: <Widget>[
      Text(
        "Welcome to CREDO",
        textAlign: TextAlign.left,
      ),
      Padding(padding: EdgeInsets.symmetric(vertical: 15)),
      Divider(
        indent: 10,
        endIndent: 10,
        height: 5,
        thickness: 2,
      ),
      Padding(padding: EdgeInsets.symmetric(vertical: 15)),

      ///TO DO large bits of text should be stored seperate and then inserted as a single value

      Text(
        'The Cosmic Ray Extremely Distributed Observatory (CREDO) Project is testing one of the many theories for what this dark matter could be – super massive particles born in the early Universe. If this theory is correct, we can’t see the super massive particles themselves, but we should be able to detect what is left when these particles come to the end of their lives, or ‘decay’. The very high energy photons predicted to result from this decay are unlike anything scientists have detected so far coming from outer space. This could be because they are very rare or, more likely, that they don’t make it all the way across the Universe to the Earth without being affected by other particles.',
        textAlign: TextAlign.left,
        textScaleFactor: 1.1,
      )
    ],
  ),
  //),
));
