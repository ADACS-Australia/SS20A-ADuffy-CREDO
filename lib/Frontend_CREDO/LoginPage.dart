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

  final _formKey = GlobalKey<FormState>();

  // Class the handles all interaction with CREDO API's
  CredoRepository _credoRepository = CredoRepository();

  @override
  void initState() {
    super.initState();
    //initialise class to load system and device info
    _credoRepository.init();
  }

  @override
  Widget build(BuildContext context) {
    //Email/username field
    // final emailField = TextField(
    //     obscureText: false,
    //     decoration: InputDecoration(
    //         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //         hintText: "Username/Email",
    //         border:
    //             OutlineInputBorder()
    //             ),
    //     onChanged: (value) {
    //       _login = value;
    //     });
    final emailField = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Username/Email",
            border: OutlineInputBorder(),
            ),
      validator: (value){
        if(value == null || value.isEmpty){
          return "Please enter username or email";
        }
        return null;
      },
      onChanged: (value) {
        _login = value;
      },      
    );

    //Password Field
    final passwordField = TextFormField(
        obscureText: true,
        // style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border: OutlineInputBorder()
            ),
        validator: (value){
          if(value == null || value.isEmpty){
            return "Please enter password";
          }
          return null;
        },
        onChanged: (value) {
          _password = value;
        });

    
    final loginButton = OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style,
      onPressed: () {
        if(_formKey.currentState!.validate()){
          _credoRepository.requestLogin(_login, _password).then((value) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
          ));
        }
      }, 
      child: Text("LOGIN")
    );

    return Form(
      key: _formKey,
      child: Scaffold(
        body: 
        // Center(
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/credo_background.png"), // TODO: background image needs to be changed
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
                        Expanded(child: emailField),
                        SizedBox(height: 24),
                        Expanded(child: passwordField),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 25), 
                    child: Container(height: 50, child: loginButton,),
                  ),
                ],
              // ),
            ),
          ),
      )
    );
  }
}
