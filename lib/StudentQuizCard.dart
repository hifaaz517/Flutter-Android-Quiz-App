import 'package:firestoredemo/CustomGradiantButton.dart';
import 'package:flutter/material.dart';

class StudentQuizCard extends StatefulWidget {
  final String question;
  final String option1;
  final String option4;
  final String option3;
  final String option2;
  final List demo;

  StudentQuizCard(
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.demo,
    this.option4,
  );

  @override
  _StudentQuizCardState createState() => _StudentQuizCardState();
}

class _StudentQuizCardState extends State<StudentQuizCard> {
  int score = 0;

  bool option1Btn = false;

  bool option2Btn = false;

  bool option3Btn = false;

  bool option4Btn = false;

  static int num = 0;
  bool x = true;

  @override
  void initState() {
    List list = [widget.option1];
    // widget.demo.shuffle();
    print('Printing Student Quiz Card');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void answerFn(int i) {
      setState(
        () {
          widget.demo[i] == widget.option1 ? this.score = 1 : this.score = 0;
          // select();
        },
      );
    }

    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(10),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Text(
                  widget.question,
                  style: TextStyle(
                      fontFamily: "RobotoMedium",
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: CustomGradiantButton(widget.demo[0], null)),
                SizedBox(
                    width: double.infinity,
                    child: CustomGradiantButton(widget.demo[1], null)),
                SizedBox(
                    width: double.infinity,
                    child: CustomGradiantButton(widget.demo[2], null)),
                SizedBox(
                    width: double.infinity,
                    child: CustomGradiantButton(widget.demo[3], null)),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        ),
      ],
    );
  }
}
