import 'package:flutter/material.dart';
import '../network/repository.dart';
import '../main.dart';

// Application Login Screen
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // login & password field values
  String _login = "";
  String _password = "";

  // Class the handles all interaction with CREDO API's
  CredoRepository _credoRepository = CredoRepository();
  // TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {
    super.initState();
    //initialise class to load system and device info
    _credoRepository.init();
  }

  @override
  Widget build(BuildContext context) {
    //Email/username field
    final emailField = TextField(
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Username/Email",
            border:
                OutlineInputBorder()
                ),
        onChanged: (value) {
          _login = value;
        });

    //Password Field
    final passwordField = TextField(
        obscureText: true,
        // style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border: OutlineInputBorder()
            ),
        onChanged: (value) {
          _password = value;
        });


    // //Login button
    // final loginButton = Material(
    //   // elevation: 5.0,
    //   // borderRadius: BorderRadius.circular(30.0),
    //   // color: Color(0xff01A0C7),
    //   child: MaterialButton(
    //     // minWidth: MediaQuery.of(context).size.width,
    //     // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     onPressed: () {
    //       // send login request to endpoint
    //         // new Center(
    //         //   child: new CircularProgressIndicator(),
    //         // );
    //       _credoRepository.requestLogin(_login, _password).then((value) => Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => MyHomePage()),
    //       ));
    //       // navigate to detection screen
    //     },
    //     child: Text("Login",
    //         // textAlign: TextAlign.center,
    //         // style: style.copyWith(
    //         //     color: Colors.white, fontWeight: FontWeight.bold)
    //             ),
    //   ),
    // );
    final loginButton = OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style,
      onPressed: () {
        _credoRepository.requestLogin(_login, _password).then((value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
        ));
        }, 
      child: Text("LOGIN")
    );

    return Scaffold(
      body: 
      // Center(
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/credo_background.png"), 
              fit: BoxFit.cover)),
          child:// Center(
            ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              padding: EdgeInsets.all(30),
              children: [
                Image(image: AssetImage('assets/images/credo_logo.png'), height: 120, width: 220,),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 350,
                  height: 250,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text("Login", style: Theme.of(context).textTheme.headline5,),
                      SizedBox(height: 24),
                      emailField,
                      SizedBox(height: 20),
                      passwordField,
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 25), //child: loginButton,
                  child: Container(height: 50, child: loginButton,),
                ),
              ],
            // ),
          ),
        ),
          // color: Colors.white,
          // child: Padding(
          //   padding: const EdgeInsets.all(36.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       emailField,
          //       passwordField,
          //       SizedBox(
          //         height: 35.0,
          //       ),
          //       loginButton,
          //     ],
          //   ),
          // ),
        // ),
      // ),
    );
  }
}
