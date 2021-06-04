import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget sciencePage = Container(
    padding: const EdgeInsets.all(32),
    alignment: Alignment.centerLeft,
    child: CustomScrollView(primary: false, slivers: <Widget>[
      SliverToBoxAdapter(
          child: ExpansionTile(
        title: Text('About Credo'),
        initiallyExpanded: true,
        children: [
          ListTile(
            title: RichText(
              text: TextSpan(
                  text:
                      'Scientists have dedicated their lives to trying to understand the Universe we live in but one mystery has remained; 95% of the Universe is invisible to us. We call 68% of the missing Universe Dark Energy and 27% Dark Matter. We know these things exist because of a variety of otherwise unexplained phenomena including the manner in which we see galaxies rotating but we have no idea what they are.'),
            ),
          )
        ],
      )),
      SliverToBoxAdapter(
          child: ExpansionTile(
        title: Text('Science Goals'),
        children: [
          ListTile(
            title: RichText(
                text: TextSpan(
                    text:
                        'CREDO is attempting to create a network of detectors that span the entire Earth, to find the very highest energy particle showers that might reach us as super massive dark matter particles decay.\nBy using CREDO on your smartphone you can help astronomers answer one of the greatest mysteries of science, the nature of dark matter.\nMore science link: ',
                    children: [
                  TextSpan(text: 'https://credo.science/credo-project-theory/')
                ])),
          )
        ],
      )),
      SliverToBoxAdapter(
          child: ExpansionTile(
        title: Text('Publications'),
        children: [
          ListTile(
            title: RichText(
              text: TextSpan(
                  text:
                      'Find all publications related to there CREDO project by following this link: ',
                  children: [
                    TextSpan(text: 'https://credo.science/publications/')
                  ]),
            ),
          )
        ],
      )),
      SliverToBoxAdapter(
          child: ExpansionTile(
        title: Text('Ways to get involved'),
        children: [
          ListTile(
            title: RichText(
              text: TextSpan(
                  text:
                      'We are always keen for new research institutions to join the collaboration as members (https://credo.science/credo-institutional-members/) or as individual researchers in supporting the open-source code development (https://github.com/credo-science)',
                  children: [TextSpan(text: '')]),
            ),
          )
        ],
      )),
    ]));
