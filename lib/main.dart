import 'package:firestoredemo/FacultyLogin.dart';
import 'package:firestoredemo/Faculty_teddy_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/QuizProfile.dart';
import './models/QA_Model.dart';
import 'FacultyLoginButtons.dart';
import 'RadiantBackground.dart';
import 'StudentLoginButton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Model(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Profile(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.black, cursorColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: RadiantBackground(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(93, 142, 155, 1.0),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 2, //extend the shadow
                          offset: Offset(
                            7.1, // Move to right 10  horizontally
                            7.1, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FacultyLoginButton(),
                      SizedBox(
                        height: 20,
                      ),
                      StudentLoginButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
