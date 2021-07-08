import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../network/repository.dart';
import 'package:credo_transcript/Frontend_CREDO/LoginPage.dart';
import 'package:email_validator/email_validator.dart';


class RegisterAccountPage extends StatefulWidget{
  @override
  _RegisterAccountPageState createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage>{

  String _fullName = "";
  String _email = "";
  String _username = "";
  String _teamName = "";
  String _password = "";
  String _confirmPassword = "";

  final _formKey = GlobalKey<FormState>();

  CredoRepository _credoRepository = CredoRepository();

  @override
  void initState() {
    super.initState();
    //initialise class to load system and device info
    _credoRepository.init();
  }

  @override
  Widget build(BuildContext context){

    final fullNameField = TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(50),
        ],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "Full Name",
            border: OutlineInputBorder(),
            ),
      validator: (value){
        if(value == null || value.isEmpty){
          return "Please enter full name";
        }
        return null;
      },
      onChanged: (value) {
        _fullName = value;
      },      
    );
    
    final emailField = TextFormField(
      decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "Email",
            border: OutlineInputBorder(),
            ),
      validator: (value){
        if(value == null || value.isEmpty){
          return "Please enter email";
        } else if (!EmailValidator.validate(value)){
          return "Please enter a valid email";
        }
        return null;
      },
      onChanged: (value) {
        _email = value;
      },      
    );

    final usernameField = TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9+.@\-_]')),
      ],
      decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "Username (letters, digits, @, -, _, +, .)",
            border: OutlineInputBorder(),
            ),
      validator: (value){
        if(value == null || value.isEmpty){
          return "Please enter username";
        }
        return null;
      },
      onChanged: (value) {
        _username = value;
      },      
    );

    final teamNameField = TextFormField(
      inputFormatters: [
          LengthLimitingTextInputFormatter(50),
      ],
      decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "Team Name",
            border: OutlineInputBorder(),
            ),
      validator: (value){
        if(value == null || value.isEmpty){
          return "Please enter team name";
        }
        return null;
      },
      onChanged: (value) {
        _teamName = value;
      },      
    );

    final passwordField = TextFormField(
        obscureText: true,
        inputFormatters: [
          LengthLimitingTextInputFormatter(128),
        ],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
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

    final confirmPasswordField = TextFormField(
        obscureText: true,
        inputFormatters: [
          LengthLimitingTextInputFormatter(128),
        ],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "Confirm Password",
            border: OutlineInputBorder()
            ),
        validator: (value){
          if(value == null || value.isEmpty){
            return "Please re-enter your password";
          }
          return null;
        },
        onChanged: (value) {
          _password = value;
        }
      );

    final signupButton = OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style,
      onPressed: () {
        if(_formKey.currentState!.validate()){
          _credoRepository.requestRegisterAccount(_fullName, "ADACS", _email, _password, _username)
          .then((value) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          ));
        }
      }, 
      child: Text("SIGN UP")
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
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                children: [
                  Image(image: AssetImage('assets/images/credo_logo.png'), height: 80, width: 200,),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: 350,
                    height: 450,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Text("Create an account", style: Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 20),
                        Expanded(child: fullNameField),
                        Expanded(child: emailField),
                        Expanded(child: usernameField,),
                        Expanded(child: teamNameField),
                        Expanded(child: passwordField),
                        Expanded(child: confirmPasswordField),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 10), 
                    child: Container(height: 50, child: signupButton,),
                  ),
                ],
              // ),
            ),
          ),
      )
    );
  }
}
