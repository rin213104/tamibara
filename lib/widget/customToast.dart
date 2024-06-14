import 'package:flutter/material.dart';

class customToast extends StatelessWidget {
  final String message;

  customToast({required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 50.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0xffFAFAFA),
            borderRadius: BorderRadius.circular(15.0), // 모서리 둥글기 조절
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/rin213104
