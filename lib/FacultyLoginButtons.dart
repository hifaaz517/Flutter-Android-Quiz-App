import 'package:flutter/material.dart';
import 'Faculty_teddy_main.dart';

class FacultyLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return FacultyMyHomePage();
            },
          ),
        );
      },
      child: Container(
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
            'Faculty Login',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "RobotoMedium",
              fontSize: 21,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
