import 'package:firestoredemo/QuizIdScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'StudentSignin.dart';

class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  void signinModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return StudentSignin();
      },
      isScrollControlled: true,
    );
  }

  void _saveForm(BuildContext context) async {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }

    form.currentState.save();

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    print('Login Success');

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return QuizIdScreen();
    }));
  }

  final form = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(5),
                height: 238,
                child: Card(
                  elevation: 7,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            autofocus: true,
                            onSaved: (value) {
                              email = value.trim();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            onSaved: (value) {
                              password = value.trim();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                          ),
                          FlatButton(
                            child: Text('Login'),
                            onPressed: () {
                              _saveForm(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: FlatButton(
                  child: Text('Signin'),
                  onPressed: () => signinModalSheet(context),
                ))
          ],
        ),
      ),
    );
  }
}
