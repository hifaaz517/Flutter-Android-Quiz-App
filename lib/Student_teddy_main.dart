import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';
import 'FacultySigin.dart';
import 'StudentSignin.dart';
import 'signin_button.dart';
import 'teddy_controller.dart';
import 'tracking_text_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentMyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class StudentMyHomePage extends StatefulWidget {
  StudentMyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StudentMyHomePage> {
  TeddyController _teddyController;
  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  void signinModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return StudentSignin();
      },
      isScrollControlled: true,
    );
  }

  String email = "", password = "";
  var focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

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
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: devicePadding.top + 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: FlareActor(
                        "assets/Teddy.flr",
                        shouldClip: false,
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        controller: _teddyController,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
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
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TrackingTextInput(
                                label: "Email",
                                hint: "What's your email address?",
                                onCaretMoved: (Offset caret) {
                                  _teddyController.lookAt(caret);
                                },
                                onTextChanged: (String value) {
                                  email = value;
                                },
                              ),
                              TrackingTextInput(
                                label: "Password",
                                hint: "Try 'bears'...",
                                isObscured: true,
                                onCaretMoved: (Offset caret) {
                                  _teddyController.coverEyes(caret != null);
                                  _teddyController.lookAt(null);
                                },
                                onTextChanged: (String value) {
                                  password = value;
                                },
                              ),
                              SigninButton(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontFamily: "RobotoMedium",
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode);

                                  Future.delayed(Duration(milliseconds: 500))
                                      .then((_) {
                                    // _teddyController.submitPassword();
                                    _teddyController.newSubmitPasswordStudent(
                                        email, password, context);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SigninButton(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontFamily: "RobotoMedium",
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          signinModalSheet(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
