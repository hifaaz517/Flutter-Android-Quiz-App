import 'package:flutter/material.dart';
import './FacultySetQuestionScreen.dart';

class CreateQuizProfile extends StatelessWidget {
  final String courseName;
  final String courseCode;
  final String slot;
  final String id;

  CreateQuizProfile({
    @required this.courseName,
    @required this.courseCode,
    @required this.slot,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return FacultySetQuestionScreen(id.toString());
          }),
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 10,
          left: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Course Name:',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      courseName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Course Code:',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    courseCode.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Slot:',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    slot.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Quiz Id:',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    id,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
