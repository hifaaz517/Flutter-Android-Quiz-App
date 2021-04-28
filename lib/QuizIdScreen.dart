import 'package:firestoredemo/CustomGradiantButton.dart';
import 'package:firestoredemo/RadiantBackground.dart';
import 'package:flutter/material.dart';
import 'package:firestoredemo/QuizInstructionScreen.dart';
import 'package:provider/provider.dart';
import 'models/QA_Model.dart';

class QuizIdScreen extends StatefulWidget {
  @override
  _QuizIdScreenState createState() => _QuizIdScreenState();
}

class _QuizIdScreenState extends State<QuizIdScreen> {
  // final quizIdController = TextEditingController();
  String quizId;

  bool buttonState = false;
  bool flag;

  final form = GlobalKey<FormState>();

  void saveForm(BuildContext context) {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }

    form.currentState.save();
    setState(() {
      buttonState = true;
    });

    Provider.of<Model>(context, listen:  false).clearItemProvider();

    Provider.of<Model>(context, listen: false)
        .getFirebaseQuestionStudent(quizId.toString().trim())
        .then((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return QuizInstructionScreen(quizId.toString().trim());
          },
        ),
      );
    });


    Future.delayed(Duration(milliseconds: 100)).then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RadiantBackground(
        child: Center(
          child: Card(
            elevation: 9,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Form(
                    key: form,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      autofocus: true,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        labelText: 'Enter Quiz Code',
                      ),
                      // controller: quizIdController,
                      onSaved: (value) {
                        this.quizId = value.toString();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter the Quiz Code';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomGradiantButton(
                      'Go',
                      () {
                        saveForm(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
