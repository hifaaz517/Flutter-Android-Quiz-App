import 'package:firestoredemo/signin_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FacultySignin extends StatefulWidget {
  @override
  _FacultySigninState createState() => _FacultySigninState();
}

class _FacultySigninState extends State<FacultySignin> {
  void _saveForm(BuildContext context) async {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }
    if (password != confirmPassword) {
      return;
    }
    form.currentState.save();

    // AuthResult result = FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(email: email, password: password)
    //     .then((currentUser) =>
    //         Firestore.instance.collection("StudentUser").document(currentUser.uid).setData(
    //           "uid" : currentUser.uid,
    //         ));

    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    // Provider.of<Profile>(context, listen: false).getFirebaseUser(user);
    print(user);

    Firestore.instance.collection('FacultyUser').document(user.uid).setData(
      {
        'uid': user.uid,
        'name': name,
        'id': id,
        'email': email,
        'code': "FacultyUser",
      },
    );
    print(user.uid);
    print(user.email);
    print('Account Created');
    Navigator.of(context).pop();
  }

  final form = GlobalKey<FormState>();
  var email;
  var id;
  var name;
  var password;
  var confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  // Box decoration takes a gradient
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.0, 1.0],
                    colors: [
                      Color.fromRGBO(170, 207, 211, 1.0),
                      Color.fromRGBO(93, 142, 155, 1.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 0,
              top: 100,
              left: 0,
              child: SingleChildScrollView(
                child: Form(
                  key: form,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 30,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(),
                          ),
                          onSaved: (value) {
                            email = value.trim();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                          autofocus: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Id',
                            labelStyle: TextStyle(),
                          ),
                          onSaved: (value) {
                            id = value.trim();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter ID';
                            }
                            return null;
                          },
                          autofocus: false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(),
                          ),
                          onSaved: (value) {
                            name = value.trim();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Name';
                            }
                            return null;
                          },
                          autofocus: false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(),
                          ),
                          onSaved: (value) {
                            password = value.trim();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                          autofocus: false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(),
                          ),
                          onSaved: (value) {
                            confirmPassword = value.trim();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Confirm Pasword';
                            }
                            return null;
                          },
                          autofocus: false,
                        ),
                        SizedBox(height: 15),
                        // FlatButton(
                        //   child: Text('Create Account'),
                        //   onPressed: () {
                        //     // _saveForm(context);
                        //     // Navigator.of(context).pop();
                        //     // Future.delayed(Duration.zero).then((_){
                        //     //   Navigator.of(context).pop();
                        //     // });
                        //   },
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SigninButton(
                            child: Text("Create Account",
                                style: TextStyle(
                                    fontFamily: "RobotoMedium",
                                    fontSize: 16,
                                    color: Colors.white)),
                            onPressed: () {
                              _saveForm(context);
                              // Navigator.of(context).pop();
                              // Future.delayed(Duration.zero).then((_) {
                              //   Navigator.of(context).pop();
                              // });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
