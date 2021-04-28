import 'package:flutter/cupertino.dart';
import 'package:date_format/date_format.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizProfile {
  final String courseName;
  final String courseCode;
  final String slot;
  final String id;

  QuizProfile(
    this.courseName,
    this.courseCode,
    this.slot,
    this.id,
  );
}

class Profile with ChangeNotifier {
  List<QuizProfile> _profiles = [
    QuizProfile(
      'iot',
      'a1',
      'slot',
      'date',
    ),
  ];

  List<QuizProfile> get profile {
    return [..._profiles];
  }

  String createId() {
    String date = formatDate(DateTime.now(), [yyyy, mm, dd]);
    String string = randomAlpha(5).toUpperCase();
    String id = '$date-$string';
    return id.toString();
  }

  void addProfile(
      String courseName, String courseCode, String slot, String courseId) {
    _profiles.add(
      QuizProfile(
        courseName,
        courseCode,
        slot,
        courseId,
      ),
    );
    notifyListeners();
  }

  FirebaseUser firebaseUserFaculty;

  void getFirebaseUserIDFaculty(FirebaseUser user) {
    this.firebaseUserFaculty = user;
  }

  FirebaseUser firebaseUserStudent;
  void getFirebaseUserIDStudent(FirebaseUser user) {
    this.firebaseUserStudent = user;
  }

  String docName;
  String getFirebaseDocName() {
    return this.docName;
  }

  Future<void> firebaseAddProfile(
      String courseName, String courseCode, String slot) async {
    String id = createId();
    this.docName = '$id'.toString();
    print('Creating Profile');
    await Firestore.instance
        .collection(this.firebaseUserFaculty.uid)
        .document(docName)
        .setData(
      {
        'Course ID': id,
        'Course Name': courseName,
        'Course Code': courseCode,
        'Slot': slot,
        'Question': [],
      },
    );

    await Firestore.instance
        .collection('QuizProfile')
        .document(docName)
        .setData(
      {
        'Course ID': id,
        'Course Name': courseName,
        'Course Code': courseCode,
        'Slot': slot,
        'Question': [],
        'Score': [],
      },
    );

    print('Profile added');
    DocumentSnapshot documentSnapshot = await Firestore.instance
        .collection(this.firebaseUserFaculty.uid)
        .document(docName)
        .get();
    var cloudCourseId = documentSnapshot['Course ID'].toString();
    var cloudCourseName = documentSnapshot['Course Name'].toString();
    var cloudCourseCode = documentSnapshot['Course Code'].toString();
    var cloudSlot = documentSnapshot['Slot'].toString();
    print('Quiz Profile Created');
    addProfile(cloudCourseName, cloudCourseCode, cloudSlot, cloudCourseId);
  }

  bool x = true;
  Future<void> getAllDocFromFirestore() async {
    if (x == true) {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection(this.firebaseUserFaculty.uid)
          .getDocuments();
      var list = querySnapshot.documents;
      int i = 1;
      print(list.length);
      for (i = 0; i < list.length; i++) {
        addProfile(
          list[i]['Course Name'],
          list[i]['Course Code'],
          list[i]['Slot'],
          list[i]['Course ID'],
        );
      }
    }
    this.x = false;
    print('Stopped');
    return null;
  }
}
