import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget sciencePage = Container(
    padding: const EdgeInsets.all(32),
    child: CustomScrollView(primary: false, slivers: <Widget>[
      ///TODO: could be replaced with a Sliver List ??!
      SliverToBoxAdapter(
          child: ExpansionTile(
        title: Text('About Credo'),
        initiallyExpanded: true,
        children: [
          ListTile(
            title: Text(
                'Scientists have dedicated their lives to trying to understand the Universe we live in but one mystery has remained; 95% of the Universe is invisible to us. We call 68% of the missing Universe Dark Energy and 27% Dark Matter. We know these things exist because of a variety of otherwise unexplained phenomena including the manner in which we see galaxies rotating but we have no idea what they are.'),
          )
        ],
      )),
      SliverToBoxAdapter(child: ExpansionTile(title: Text('Science Goals'))),
      SliverToBoxAdapter(child: ExpansionTile(title: Text('Publications'))),
      SliverToBoxAdapter(
          child: ExpansionTile(title: Text('More ways to get involved'))),
    ]));
