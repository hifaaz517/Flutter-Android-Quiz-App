import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/QA_Model.dart';

class CustomText extends StatefulWidget {
  CustomText({
    @required this.text,
    @required this.score,
    @required this.id,
  });
  final String text, id;
  final int score;

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  void initState() {
    Provider.of<Model>(context,listen: false).pushscore(widget.score,widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'You scored ${widget.score}',
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontFamily: "RobotoMedium",
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
