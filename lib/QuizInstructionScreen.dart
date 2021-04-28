import 'package:firestoredemo/CustomGradiantButton.dart';
import 'package:firestoredemo/RadiantBackground.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firestoredemo/StudentQuizScreen.dart';
import './models/QA_Model.dart';

class QuizInstructionScreen extends StatefulWidget {
  final String id;
  QuizInstructionScreen(
    this.id,
  );

  @override
  _QuizInstructionScreenState createState() => _QuizInstructionScreenState();
}

class _QuizInstructionScreenState extends State<QuizInstructionScreen> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Model>(context).findById(widget.id);
    final length = data.length;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RadiantBackground(
            child: length == 0
                ? Center(
                    child: Text(
                      'YOU ENTERED THE WRONG QUIZ CODE',
                      style: TextStyle(
                        fontFamily: "RobotoMedium",
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                : Center(
                    child: CustomGradiantButton(
                      'Go',
                      () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) {
                              return StudentQuizScreen(data,widget.id);
                            },
                          ),
                        );
                      },
                    ),
                  )),
      ),
    );
  }
}
