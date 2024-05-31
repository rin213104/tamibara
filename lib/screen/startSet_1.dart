import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'startSet_2.dart';
import '../const/colors.dart';

void main() {
  runApp(Set1());
}

class Set1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(), // StartSet1 위젯을 홈으로 설정
    );
  }
}

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? selectedGoal; // 사용자가 선택한 목표를 저장할 변수 (장/단기)

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, screenHeight * 0.1, 0, 0),
                      child: Text(
                        "환영합니다!",
                        style: TextStyle(
                          color: Color(0xFF6F867C),
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        "당신의 목표를 알려 주세요!",
                        style: TextStyle(
                          color: Color(0xFF6F867C),
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, screenHeight * 0.03, 0, screenHeight * 0.05),
                      child: Image.asset(
                        'assets/images/chap01.png',
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.1,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.07,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedGoal = '장기적인 목표';
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => NickNameScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    var begin = Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;
                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xffF7FFFD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: screenWidth * 0.01),
                                  child: Text(
                                    '장기적인 목표',
                                    style: TextStyle(
                                      color: Color(0xff6F867C),
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Padding(
                                  padding: EdgeInsets.only(right: screenWidth * 0.2),
                                  child: Text(
                                    '- 시험, 자격증 등',
                                    style: TextStyle(
                                      color: Color(0xff6F867C),
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        SizedBox(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.07,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedGoal = '단기적인 목표';
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => NickNameScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    var begin = Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;
                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xffF7FFFD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: screenWidth * 0.01),
                                  child: Text(
                                    '단기적인 목표',
                                    style: TextStyle(
                                      color: Color(0xff6F867C),
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Padding(
                                  padding: EdgeInsets.only(right: screenWidth * 0.15),
                                  child: Text(
                                    '- 일상 공부, 할 일 등',
                                    style: TextStyle(
                                      color: Color(0xff6F867C),
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}