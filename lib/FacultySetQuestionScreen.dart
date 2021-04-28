import 'package:firestoredemo/RadiantBackground.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firestoredemo/FacultySetQuestionModalSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoredemo/StudentQuizCard.dart';
import './models/QA_Model.dart';

class FacultySetQuestionScreen extends StatefulWidget {
  final String id;

  FacultySetQuestionScreen(this.id);

  @override
  _FacultySetQuestionScreenState createState() =>
      _FacultySetQuestionScreenState();
}

class _FacultySetQuestionScreenState extends State<FacultySetQuestionScreen> {
  void setQuestionModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return FacultySetQuestionModalSheet(widget.id);
      },
      isScrollControlled: true,
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      print('initstate getting cloud data');
      Provider.of<Model>(context, listen: false)
          .getFirebaseQuestion(widget.id.toString());
      Provider.of<Model>(context, listen: false).clearItemProvider();
      print('initistate got data');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Model>(context).findById(widget.id.toString());
    final user = Provider.of<Model>(context, listen: false).firebaseUserFaculty.uid;
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.id,
            style: TextStyle(
              fontFamily: "RobotoMedium",
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                var dataList =
                    Provider.of<Model>(context, listen: false).getDataList();
                Provider.of<Model>(context, listen: false).firebaseAddQuestion(
                  widget.id.toString(),
                  dataList,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: RadiantBackground(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(user).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, i) => StudentQuizCard(
                      data[i].question,
                      data[i].option1,
                      data[i].option2,
                      data[i].option3,
                      [
                        data[i].option1,
                        data[i].option2,
                        data[i].option3,
                        data[i].option4,
                      ],
                      data[i].option4,
                    ),
                  );
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
          child: Icon(Icons.add),
          onPressed: () => setQuestionModalSheet(context),
        ),
      ),
    );
  }
}
