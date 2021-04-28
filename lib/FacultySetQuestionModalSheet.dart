import 'package:firestoredemo/CustomGradiantButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/QA_Model.dart';

class FacultySetQuestionModalSheet extends StatefulWidget {
  final String id;
  FacultySetQuestionModalSheet(this.id);
  @override
  _FacultySetQuestionModalSheetState createState() =>
      _FacultySetQuestionModalSheetState();
}

class _FacultySetQuestionModalSheetState
    extends State<FacultySetQuestionModalSheet> {
  _FacultySetQuestionModalSheetState();
  final _form = GlobalKey<FormState>();

  var question, option1, option2, option3, option4;

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Model>(context, listen: false).addQuestion(
      widget.id,
      this.question,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(170, 207, 211, 1.0),
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 4,
                  style: TextStyle(fontSize: 20),
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Enter Question'),
                  onSaved: (value) {
                    this.question = value.toString();
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter question.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(labelText: 'Option 1 / Answer'),
                  onSaved: (value) {
                    this.option1 = value.toString();
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter option 1.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(labelText: 'Option 2'),
                  onSaved: (value) {
                    this.option2 = value.toString();
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter option 2.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(labelText: 'Option 3'),
                  onSaved: (value) {
                    this.option3 = value.toString();
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter option 3.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(labelText: 'Option 4'),
                  onSaved: (value) {
                    this.option4 = value.toString();
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter option 4.';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                CustomGradiantButton(
                  'Done',
                  () {
                    _saveForm();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
