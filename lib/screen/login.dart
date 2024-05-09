import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/startSet_1.dart';
import '../const/colors.dart';

void main() {
  runApp(loginScreen());
}

class loginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFBFEBE1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Image.asset(
                'assets/images/카피바라 성년.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 100),
              Text(
                '--- Sign in with ---',
                style: TextStyle(
                  color: TEXT_COLOR,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 250,
                height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFEA29),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/pngegg.png',
                        width: 20,
                        height: 20,
                      ),
                      Expanded(
                        child: Text(
                          'Kakao',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF3C1E1E),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
          ),
              SizedBox(height: 10),
              SizedBox(
                width: 250,
                height: 40,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDFDFDF), // D8D7DB 색상으로 출력됨
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/person.png',
                          width: 30,
                          height: 30,
                        ),
                        Expanded(
                        child: Text(
                          'Guest',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}