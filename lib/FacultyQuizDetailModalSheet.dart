import 'package:firestoredemo/CustomGradiantButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/QuizProfile.dart';

class FacultyQuizDetailModalSheet extends StatelessWidget {
  final courseNameController = TextEditingController();
  final courseCodeController = TextEditingController();
  final slotController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      color: Color.fromRGBO(170, 207, 211, 1.0),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: 'Course Name'),
                autofocus: true,
                controller: courseNameController,
              ),
              TextField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: 'Course Code'),
                controller: courseCodeController,
              ),
              TextField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: 'Slot'),
                controller: slotController,
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                  width: double.infinity,
                  child: CustomGradiantButton(
                    'Create Profile',
                    () {
                      // Provider.of<Profile>(context, listen: false).addProfile(
                      //   courseNameController.text,
                      //   courseCodeController.text,
                      //   slotController.text,
                      // );
                      Provider.of<Profile>(
                        context,
                        listen: false,
                      ).firebaseAddProfile(
                        courseNameController.text,
                        courseCodeController.text,
                        slotController.text,
                      );

                      Navigator.pop(context); //Close Modal Bottom sheet;
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
