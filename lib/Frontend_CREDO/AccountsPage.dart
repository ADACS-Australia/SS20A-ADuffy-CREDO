import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///TODO: How do we prefill all the fields with stuff from the db and then on saqve update them all ??

class AccountsPage extends StatefulWidget {

  @override
  AccountsPageState createState() {
    return AccountsPageState();
  }
}

class AccountsPageState extends State<AccountsPage> {
  
  String fullName = 'Full Name';
  String emailAdress = 'UserEmail@somewhere.com';
  String userName = 'Username';
  String teamName = 'Team Name';
  String password = 'password';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Information'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: fullName,
                decoration: const InputDecoration(
                  hintText: 'First and Last Name',
                  labelText: 'Full Name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: userName,
                decoration: const InputDecoration(
                  hintText: 'Username shown to other users',
                  labelText: 'Username',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: emailAdress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: teamName,
                decoration: const InputDecoration(
                  ///TODO: should there be a different system for teams ??
                  hintText: 'Your Team Name',
                  labelText: 'Email',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   initialValue: password,
              //   decoration: const InputDecoration(
              //     hintText: 'Enter your password',
              //     labelText: 'Password',
              //   ),
              //   obscureText: true,
              //   validator: (String? value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   /// TODO: replace initial input text with the user information we get
              //   initialValue: password,
              //   decoration: const InputDecoration(
              //     hintText: 'Enter your password',
              //     labelText: 'Password',
              //   ),
              //   validator: (String? value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please confirm password';
              //     }
              //     return null;
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffee7355))),
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
