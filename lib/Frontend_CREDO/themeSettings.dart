import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData credoTheme() {
  //static ThemeData get darkTheme {
  return ThemeData(
    canvasColor: Colors.black,

    primaryColor: Color(0xFF5C4B51), // for header and footer bars
    accentColor: Color(0xFFEE7355), //for buttons etc.
    errorColor: Color(0xFFED4337),
    backgroundColor: Color(0xFF030202),
    dividerColor: Color(0xFF2E2227),
    scaffoldBackgroundColor: Color(0xFF1B1B1B),
    bottomAppBarColor: Color(0xFF5C4B51),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF5C4B51),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFF2E2227),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Color(0xFF5C4B51),
    ),
    dividerTheme: DividerThemeData(color: Color(0x80CEC8C8)),
    iconTheme: IconThemeData(color: Color(0xFFCEC8C8)),

    //Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFFEE7355)))),
    buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFFEE7355), focusColor: Color(0xFFEE7355)),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white))),
    // All things related to text
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Color(0xFFEE7355)),
      bodyText2: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.white),
      button: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Color(0xFFCEC8C8)),
      subtitle2: TextStyle(color: Color(0xFF8D8D8D)),
      headline6: TextStyle(color: Colors.white),
    ),
  );

  //}
}
