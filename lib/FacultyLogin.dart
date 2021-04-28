import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoredemo/QuizProfileScreen.dart';
import 'package:firestoredemo/FacultySigin.dart';
import 'package:provider/provider.dart';
import 'models/QuizProfile.dart';
import 'models/QA_Model.dart';

class FacultyLogin extends StatefulWidget {
  @override
  _FacultyLoginState createState() => _FacultyLoginState();
}

class _FacultyLoginState extends State<FacultyLogin> {
  void signinModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return FacultySignin();
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

    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('printing erroe message');
      print(e.message);
    }

    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('printing uid');
    print(user.uid);

    Provider.of<Profile>(context, listen: false).getFirebaseUserIDFaculty(user);
    Provider.of<Model>(context, listen: false).getFirebaseUserIDFaculty(user);

    print('Login Success');

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return QuizProfilescreen();
    }));
  }

  void newfn(BuildContext context) async {
    var xxx = true;
    if (form.currentState.validate()) {
      form.currentState.save();
      try {
        print('enter try');
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password))
            .user;
      } catch (e) {
        print('enter catch');
        print(e);
        print(e.code);
        switch (e.code) {
          case "ERROR_WRONG_PASSWORD":
            xxx = false;
            print('wrong password');
            break;
          default:
        }
        // xxx = false;
      }
      print('exit try');
    }
    if (xxx == true) {
      final FirebaseUser users = await FirebaseAuth.instance.currentUser();
      print('printing uid');
      print(users.uid);

      Provider.of<Profile>(context, listen: false).getFirebaseUserIDFaculty(users);
      Provider.of<Model>(context, listen: false).getFirebaseUserIDFaculty(users);
      print('navigate');
      Future.delayed(Duration.zero).then((_) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return QuizProfilescreen();
        }));
      });
    }
  }

  final form = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Login'),
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
                              newfn(context);
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
