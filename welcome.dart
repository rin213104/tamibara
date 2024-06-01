import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';
import 'goal.dart';
import 'to_do_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String selectedImage;

  WelcomeScreen({required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        color: PRIMARY_COLOR,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, screenHeight * 0.15, 0, 0),
                      child: Text(
                        '준비가 끝났습니다!',
                        style: TextStyle(
                          color: TEXT_COLOR,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, screenHeight * 0.001),
                      child: Text(
                        '이제 목표를 향해 달려 볼까요?',
                        style: TextStyle(
                          color: TEXT_COLOR,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToDoScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        selectedImage,
                        width: screenWidth * 0.6,
                        height: screenWidth * 0.6,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    Text(
                      '^',
                      style: TextStyle(
                        color: TEXT_COLOR,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '눌러서 시작',
                      style: TextStyle(
                        color: Color(0xFF4D6058),
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}