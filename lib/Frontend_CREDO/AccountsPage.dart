import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../network/repository.dart';
import '../utils/prefs.dart';

///TODO: How do we prefill all the fields with stuff from the db and then on saqve update them all ??

class AccountsPage extends StatefulWidget {

  @override
  AccountsPageState createState() {
    return AccountsPageState();
  }
}

class AccountsPageState extends State<AccountsPage> {

  String fullName = '';
  String emailAdress = '';
  String userName = '';
  String teamName = '';
  // String password = 'password';

  CredoRepository _credoRepository = CredoRepository();

  Future<void> getAccountInfo() async {
    userName = await Prefs.getPrefString(Prefs.USER_LOGIN, defaultValue: '');
    fullName = await Prefs.getPrefString(Prefs.USER_DISPLAY_NAME, defaultValue: '');
    emailAdress = await Prefs.getPrefString(Prefs.USER_EMAIL, defaultValue: '');
    teamName = await Prefs.getPrefString(Prefs.USER_TEAM, defaultValue: '');
  }

  @override
  void initState() {
    super.initState();    
    getAccountInfo();
  }
    
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<void>(
        initialData: false,
        future: getAccountInfo(), 
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
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
                      onChanged: (String newValue){   
                        print(newValue);
                        fullName = newValue;                    
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   initialValue: userName,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Username shown to other users',
                    //     labelText: 'Username',
                    //   ),
                    //   validator: (String? value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter some text';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    TextFormField(
                      initialValue: emailAdress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                      ),
                      onChanged: (String newValue){                       
                        emailAdress = newValue;
                      },
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
                        labelText: 'Team Name',
                      ),
                      onChanged: (String newValue) {
                        teamName = newValue;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
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
                            _credoRepository.requestUpdateUserInfo(teamName, fullName, 'en');
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
          else{
            return Text("loading...");
          }
        });
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Account Information'),
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.all(32),
    //     child: Form(
    //       key: _formKey,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           TextFormField(
    //             initialValue: fullName,
    //             decoration: const InputDecoration(
    //               hintText: 'First and Last Name',
    //               labelText: 'Full Name',
    //             ),
    //             validator: (String? value) {
    //               if (value == null || value.isEmpty) {
    //                 return 'Please enter some text';
    //               }
    //               return null;
    //             },
    //           ),
    //           // TextFormField(
    //           //   initialValue: userName,
    //           //   decoration: const InputDecoration(
    //           //     hintText: 'Username shown to other users',
    //           //     labelText: 'Username',
    //           //   ),
    //           //   validator: (String? value) {
    //           //     if (value == null || value.isEmpty) {
    //           //       return 'Please enter some text';
    //           //     }
    //           //     return null;
    //           //   },
    //           // ),
    //           TextFormField(
    //             initialValue: emailAdress,
    //             decoration: const InputDecoration(
    //               hintText: 'Enter your email',
    //               labelText: 'Email',
    //             ),
    //             validator: (String? value) {
    //               if (value == null || value.isEmpty) {
    //                 return 'Please enter some text';
    //               }
    //               return null;
    //             },
    //           ),
    //           TextFormField(
    //             initialValue: teamName,
    //             decoration: const InputDecoration(
    //               ///TODO: should there be a different system for teams ??
    //               hintText: 'Your Team Name',
    //               labelText: 'Team Name',
    //             ),
    //             validator: (String? value) {
    //               if (value == null || value.isEmpty) {
    //                 return 'Please enter some text';
    //               }
    //               return null;
    //             },
    //           ),
    //           // TextFormField(
    //           //   initialValue: password,
    //           //   decoration: const InputDecoration(
    //           //     hintText: 'Enter your password',
    //           //     labelText: 'Password',
    //           //   ),
    //           //   obscureText: true,
    //           //   validator: (String? value) {
    //           //     if (value == null || value.isEmpty) {
    //           //       return 'Please enter some text';
    //           //     }
    //           //     return null;
    //           //   },
    //           // ),
    //           // TextFormField(
    //           //   /// TODO: replace initial input text with the user information we get
    //           //   initialValue: password,
    //           //   decoration: const InputDecoration(
    //           //     hintText: 'Enter your password',
    //           //     labelText: 'Password',
    //           //   ),
    //           //   validator: (String? value) {
    //           //     if (value == null || value.isEmpty) {
    //           //       return 'Please confirm password';
    //           //     }
    //           //     return null;
    //           //   },
    //           // ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 16.0),
    //             child: ElevatedButton(
    //               style: ButtonStyle(
    //                   backgroundColor:
    //                       MaterialStateProperty.all(Color(0xffee7355))),
    //               onPressed: () {
    //                 // Validate will return true if the form is valid, or false if
    //                 // the form is invalid.
    //                 if (_formKey.currentState!.validate()) {
    //                   // Process data.
    //                 }
    //               },
    //               child: const Text('Save'),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
