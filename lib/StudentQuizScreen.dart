import 'package:firestoredemo/CustomText.dart';
import 'package:firestoredemo/RadiantBackground.dart';
import 'package:flutter/material.dart';

class StudentQuizScreen extends StatefulWidget {
  final List data;
  final String id;
  StudentQuizScreen(this.data,this.id);

  @override
  _StudentQuizScreenState createState() => _StudentQuizScreenState();
}

class _StudentQuizScreenState extends State<StudentQuizScreen> {
  List dummy;
  List xxx = [];
  void initState() {
    // List num = List.generate(5, (i) => i);
    // num.shuffle();
    for (int i = 0; i < widget.data.length; i++) {
      dummy = [
        widget.data[i].option1,
        widget.data[i].option2,
        widget.data[i].option3,
        widget.data[i].option4,
      ];
      dummy.shuffle();
      dummy.add(widget.data[i].question);
      // print(dummy);
      xxx.add(dummy);
    }

    super.initState();
  }

  int score = 0;

  bool option1Btn = false;

  bool option2Btn = false;

  bool option3Btn = false;

  bool option4Btn = false;

  int questionIndex = 0;
  int x = 0;

  // List<QAModel> _data ;
  @override
  Widget build(BuildContext context) {
    // int a = 0;
    // int xxx() {
    //   a++;
    //   return a - 1;
    // }

    // final _data = Provider.of<Model>(context).findById(widget.quizId);
    // final _providerData = Provider.of<Model>(context);
    // final _data = _providerData.items;

    // List list = [
    //   widget.data[questionIndex].option1,
    //   widget.data[questionIndex].option2,
    //   widget.data[questionIndex].option3,
    //   widget.data[questionIndex].option4,
    // ];
    // list.shuffle();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: questionIndex < xxx.length
            ? RadiantBackground(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            xxx[questionIndex][4],
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ), //Question
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  option1Btn = true;
                                  option2Btn = false;
                                  option3Btn = false;
                                  option4Btn = false;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromRGBO(160, 92, 147, 1.0),
                                      Color.fromRGBO(115, 82, 135, 1.0)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    xxx[questionIndex][0],
                                    style: option1Btn
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMedium",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          )
                                        : TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMedium",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  option1Btn = false;
                                  option2Btn = true;
                                  option3Btn = false;
                                  option4Btn = false;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromRGBO(160, 92, 147, 1.0),
                                      Color.fromRGBO(115, 82, 135, 1.0)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    xxx[questionIndex][1],
                                    style: option2Btn
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMedium",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          )
                                        : TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMedium",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  option1Btn = false;
                                  option2Btn = false;
                                  option3Btn = true;
                                  option4Btn = false;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromRGBO(160, 92, 147, 1.0),
                                      Color.fromRGBO(115, 82, 135, 1.0)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    xxx[questionIndex][2],
                                    style: option3Btn
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMedium",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          )
                                        : TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMedium",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  option1Btn = false;
                                  option2Btn = false;
                                  option3Btn = false;
                                  option4Btn = true;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromRGBO(160, 92, 147, 1.0),
                                      Color.fromRGBO(115, 82, 135, 1.0)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    xxx[questionIndex][3],
                                    style: option4Btn
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMedium",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          )
                                        : TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMedium",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (option1Btn == true) {
                                      xxx[questionIndex][0] ==
                                              widget.data[questionIndex].option1
                                          ? score = score + 1
                                          : score = score + 0;
                                    }
                                    if (option2Btn == true) {
                                      xxx[questionIndex][1] ==
                                              widget.data[questionIndex].option1
                                          ? score = score + 1
                                          : score = score + 0;
                                    }
                                    if (option3Btn == true) {
                                      xxx[questionIndex][2] ==
                                              widget.data[questionIndex].option1
                                          ? score = score + 1
                                          : score = score + 0;
                                    }
                                    if (option4Btn == true) {
                                      xxx[questionIndex][3] ==
                                              widget.data[questionIndex].option1
                                          ? score = score + 1
                                          : score = score + 0;
                                    }
                                    questionIndex++;
                                    option1Btn = false;
                                    option2Btn = false;
                                    option3Btn = false;
                                    option4Btn = false;
                                  });
                                  print(score);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color.fromRGBO(160, 92, 147, 1.0),
                                        Color.fromRGBO(115, 82, 135, 1.0)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "RobotoMedium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : RadiantBackground(
                child: CustomText(
                  text: score.toString(),
                  score: score,
                  id: widget.id,
                ),
              ),
        //ListView.builder(
        //   itemCount: _data.length > 10 ? 10 : _data.length,
        //   itemBuilder: (ctx, i) => StudentQuizCard(
        //     _data[list[a]].question,
        //     _data[list[a]].option1,
        //     _data[list[a]].option2,
        //     _data[list[a]].option3,
        //     [
        //       _data[list[a]].option1,
        //       _data[list[a]].option2,
        //       _data[list[a]].option3,
        //       _data[list[a]].option4,
        //     ],
        //     _data[list[xxx()]].option4,
        //   ),
        // ),
      ),
    );
  }
}
