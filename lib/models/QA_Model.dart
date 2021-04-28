import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QAModel {
  final String id;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  QAModel({
    this.id,
    @required this.question,
    @required this.option1,
    @required this.option2,
    @required this.option3,
    @required this.option4,
  });
}

class Model with ChangeNotifier {
  List<QAModel> _items = [
    QAModel(
      id: 'date',
      question: '1',
      option1: 'answer',
      option2: 'ccc',
      option3: 'ddd',
      option4: 'eee',
    ),
    QAModel(
      id: 'date',
      question: '2',
      option1: 'answer',
      option2: '23dsd',
      option3: '3dd',
      option4: 'sdfads',
    ),
    QAModel(
      id: 'date',
      question: '3',
      option1: 'answer',
      option2: '333dfadsf',
      option3: '333dfadsf',
      option4: '333eeedfad',
    ),
    QAModel(
      id: 'date',
      question: '4',
      option1: 'answer',
      option2: '44ccdadc',
      option3: '44dwe2dd',
      option4: '44eedadf2e',
    ),
    QAModel(
      id: 'date',
      question: '5',
      option1: 'answer',
      option2: '555ccdadc',
      option3: '555dwe2dd',
      option4: '555eedadf2e',
    ),
    QAModel(
      id: 'date',
      question: '6',
      option1: 'answer',
      option2: '66ccdadc',
      option3: '66dwe2dd',
      option4: '66eedadf2e',
    ),
  ];

  List<QAModel> get items {
    return [..._items];
  }

  void addQuestion(
    String id,
    String question,
    String option1,
    String option2,
    String option3,
    String option4,
  ) {
    final newQuestion = QAModel(
      id: id,
      question: question,
      option1: option1,
      option2: option2,
      option3: option3,
      option4: option4,
    );

    _items.add(newQuestion);
    notifyListeners();
    // print('Question Added to Provider list');

    var list = [
      question,
      option1,
      option2,
      option3,
      option4,
    ];

    dataList.add(list);
    // print(dataList);
  }

  void clearItemProvider() {
    _items.clear();
  }

  List dataList = [];

  List<QAModel> findById(String qId) {
    List list = _items.where((i) {
      return i.id == qId;
    }).toList();
    // list.shuffle();
    return list;
  }

  FirebaseUser firebaseUserFaculty;

  void getFirebaseUserIDFaculty(FirebaseUser user) {
    this.firebaseUserFaculty = user;
  }

  FirebaseUser firebaseUserStudent;
  void getFirebaseUserIDStudent(FirebaseUser user) {
    this.firebaseUserStudent = user;
  }

  bool flag = true; // flag for getFirebaseQuestion

  List questionList = [];

  Future<void> getFirebaseQuestion(String id) async {
    var dummy = [
      'sdfsdfa',
      'sdfsadfasd',
      'dfasdfsadf',
      'dfdsfadfa',
      'dsafasdfas'
    ];

    dataList.add(dummy);

    questionList.add(dummy);

    dataList.clear();
    questionList.clear();
    DocumentSnapshot documentSnapshot = await Firestore.instance
        .collection(this.firebaseUserFaculty.uid)
        .document(id)
        .get();

    print('Printing Document Snapshot');
    print(documentSnapshot['Question']);

    print(documentSnapshot);
    var cloudQuestion = documentSnapshot['Question'];
    print(json.decode(cloudQuestion.toString()));
    var decoded = json.decode(cloudQuestion.toString());
    if (this.flag == true) {
      for (int i = 0; i < Map.fromIterable(decoded[0]).length; i++) {
        List dummy = [];
        for (int j = 0; j <= 4; j++) {
          dummy.add(decoded[0][i][j]);
        }
        questionList = dummy;
        print(questionList);

        addQuestion(
          id,
          questionList[0],
          questionList[1],
          questionList[2],
          questionList[3],
          questionList[4],
        );
      }
      // this.flag = false;
    }
  }

  Future<void> pushscore(int score, String id) async {
    DocumentSnapshot documentSnapshot = await Firestore.instance
        .collection("StudentUser")
        .document(this.firebaseUserStudent.uid)
        .get();
    print('push score');

    String studentName, studentId;
    studentName = documentSnapshot['name'];
    studentId = documentSnapshot['id'];

    List list = [studentId, studentName, score];
    print(list);
    print(id);

    await Firestore.instance.collection('QuizProfile').document(id).updateData({
      'Score': [],
    });

    DocumentSnapshot documentSnapshot1 =
        await Firestore.instance.collection("QuizProfile").document(id).get();

    List listnew = [];

    
    // listnew.add(documentSnapshot1['Score']);
    print('printing new list');
    print(documentSnapshot1['Score']);

    print(documentSnapshot.data.toString());
    List listnew2 = documentSnapshot1['Score'];
    if (listnew2.isEmpty) {
      listnew2.add(list);
      print('object');
      print(listnew2);
    } else {
      print(listnew2);
      print('object2');
    }


    // listnew.add(list);
    await Firestore.instance.collection('QuizProfile').document(id).updateData({
      'Score': [json.encode(listnew2)],
    });

    // await Firestore.instance.collection('QuizProfile').document(id).setData({
    //   'Score': ['fasdfas','sdfsadf','dfasdfas'],
    // });
  }

  // Future<void> pushscore(int score, String id) async {
  //   print('Starting QuizProfile');
  //   QuerySnapshot querySnapshot =
  //       await Firestore.instance.collection('QuizProfile').getDocuments();
  //   print('MEKON');
  //   await Firestore.instance.collection('QuizProfile').document('20200416-MEKON').setData({
  //     'Score': ['4444444444','222222222','00000000'],
  //   });

  //   List<DocumentSnapshot> result = querySnapshot.documents;
  //   var list = [];
  //   result.forEach((data) => list.add(data.documentID));
  //   print(
  //       '------------------printing QuizProfile document list------------------');
  //   print(list);
  //   print('Starting StudentUser');
  //   QuerySnapshot querySnapshot1 =
  //       await Firestore.instance.collection('StudentUser').getDocuments();
  //     List<DocumentSnapshot> result1 = querySnapshot.documents;
  //     list.clear();
  //     result1.forEach((data)=> list.add(data.documentID));
  //     print('-----------------------------Printing StudentUser document list----------------------');
  //     print(list);

  //     print('Starting DdLicZEcvvQYkTKhZGNxRm1Ukao1');
  //     QuerySnapshot querySnapshot2 =
  //       await Firestore.instance.collection('DdLicZEcvvQYkTKhZGNxRm1Ukao1').getDocuments();
  //       List<DocumentSnapshot> result2 = querySnapshot.documents;
  //       list.clear();
  //       result2.forEach((data)=> list.add(data.documentID));
  //       print(list);

  // }

  // 'Score': [json.encode(null)],

  // bool firebaseQuestionStudentFlag;

  // bool getFirebaseQuestionStudentFlagValue() {
  //   return this.firebaseQuestionStudentFlag;
  // }

  Future<dynamic> getFirebaseQuestionStudent(String id) async {
    return Future.delayed(Duration.zero).then((_) async {
      QuerySnapshot documentSnapshot = await Firestore.instance
          .collection('QuizProfile'.toString().trim())
          .getDocuments();

      List<DocumentSnapshot> result = documentSnapshot.documents;
      // print(result);
      // result.forEach((data) => print(data.documentID));
      var list = [];
      result.forEach((data) => list.add(data.documentID.trim()));
      // print('Printing List value');
      int indexValue = 0;

      // print(id);

      if (list.contains(id)) {
        for (int i = 0; i < documentSnapshot.documents.length; i++) {
          // print('For loop');
          if (id == list[i].toString().trim()) {
            // print('If Statement');
            // print(list[i].toString().trim());
            indexValue = i;
          }
        }

        // print(documentSnapshot.documents[indexValue].data['Question']);

        var questionList;
        // print(documentSnapshot);
        var cloudQuestion =
            documentSnapshot.documents[indexValue].data['Question'];

        // print(json.decode(cloudQuestion.toString()));
        var decoded = json.decode(cloudQuestion.toString());
        for (int i = 0; i < Map.fromIterable(decoded[0]).length; i++) {
          List dummy = [];
          for (int j = 0; j <= 4; j++) {
            dummy.add(decoded[0][i][j]);
          }
          questionList = dummy;
          // print(questionList);

          addQuestion(
            id.toString().trim(),
            questionList[0],
            questionList[1],
            questionList[2],
            questionList[3],
            questionList[4],
          );
        }
        // print('setting flag true');
        // this.firebaseQuestionStudentFlag = true;
        return true;
      }
      // print('settng flag false');
      // this.firebaseQuestionStudentFlag = false;
      return false;
    });
  }

  // Future<void> getFirebaseQuestionStudent(String id) async {
  //   print('getFirebaseQuestionStudent');
  //   print(id);
  //   DocumentSnapshot snapshot =
  //       await Firestore.instance.collection('QuizProfile').document(id).get();
  //   var questionList;
  //   // print(snapshot['Question'][0]);
  //   var cloudQuestion = snapshot['Question'];
  //   print(cloudQuestion);
  //   // print(json.decode(cloudQuestion.toString()));
  //   print('json object');
  //   var decoded = json.decode(cloudQuestion.toString());
  //   for (int i = 0; i < Map.fromIterable(decoded[0]).length; i++) {
  //     List dummy = [];
  //     for (int j = 0; j <= 4; j++) {
  //       dummy.add(decoded[0][i][j]);
  //     }
  //     questionList = dummy;
  //     print(questionList);

  //     addQuestion(
  //       id,
  //       questionList[0],
  //       questionList[1],
  //       questionList[2],
  //       questionList[3],
  //       questionList[4],
  //     );
  //   }
  // }

  int x = 0;

  getDataList() {
    return this.dataList;
  }

  Future<void> firebaseAddQuestion(
    String id,
    List list,
  ) async {
    await Firestore.instance
        .collection(this.firebaseUserFaculty.uid)
        .document(id.toString())
        .updateData({
      'Question': [json.encode(list)],
    });
    print('Question Added to Database');
    await Firestore.instance
        .collection('QuizProfile')
        .document(id.toString())
        .updateData({
      'Question': [json.encode(list)],
    });

    // await Firestore.instance
    //     .collection('StudentUser')
    //     .document(id.toString().trim())
    //     .updateData({
    //   'Question': [json.encode(list)],
    // });
  }

  int cal(int score) {
    return score;
  }
}
