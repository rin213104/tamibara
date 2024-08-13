import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';
import 'dart:async';
import 'startSet_3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    // 깜빡이는 속도 조절
    Timer.periodic(Duration(milliseconds: 650), (timer) {
      setState(() {
        _opacity = _opacity == 1.0 ? 0 : 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 값 받아와서 저장
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Color(0xFFBFEBE1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/capybara/카피바라성년.png',
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
            ),
            SizedBox(height: screenHeight * 0.15),
            SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharacterSelect(), // startSet_1 화면으로 전환
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9CDCC1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '시작하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF304C49),
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 1),
              child: Text(
                'Press the Button',
                style: TextStyle(
                  color: TEXT_COLOR,
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}