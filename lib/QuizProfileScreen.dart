import 'package:firestoredemo/RadiantBackground.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firestoredemo/CreateQuizProfile.dart';
import './models/QuizProfile.dart';
import 'models/QA_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoredemo/FacultyQuizDetailModalSheet.dart';

class QuizProfilescreen extends StatefulWidget {
  @override
  _QuizProfilescreenState createState() => _QuizProfilescreenState();
}

class _QuizProfilescreenState extends State<QuizProfilescreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Profile>(context).getAllDocFromFirestore();
    final user = Provider.of<Model>(context, listen: false).firebaseUserFaculty.uid;

    final _providerData = Provider.of<Profile>(context);
    // Provider.of<Model>(context, listen: false).flag = true;
    final _data = _providerData.profile;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Quiz Profile',
          style: TextStyle(
            fontFamily: "RobotoMedium",
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return FacultyQuizDetailModalSheet();
                },
              );
            },
          ),
        ],
      ),
      body: RadiantBackground(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection(user).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('data');
                break;
              default:
                return ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (ctx, i) => CreateQuizProfile(
                    courseName: _data[i].courseName,
                    courseCode: _data[i].courseCode,
                    slot: _data[i].slot,
                    id: _data[i].id,
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
