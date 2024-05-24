import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/startSet_1.dart';
import '../const/colors.dart';

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

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면 크기 값 받아와서 저장
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            Image.asset(
              'assets/images/카피바라 성년.png',
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
            ),
            SizedBox(height: screenHeight * 0.15),
            Text(
              '--- Sign in with ---',
              style: TextStyle(
                color: TEXT_COLOR,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            SizedBox(
              width: screenWidth * 0.65,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFEA29),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(screenWidth * 0.02, 0, screenWidth * 0.05, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/pngegg.png',
                          width: screenWidth * 0.05,
                          height: screenWidth * 0.05,
                        ),
                        Expanded(
                          child: Text(
                            'Kakao',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF3C1E1E),
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            SizedBox(
              width: screenWidth * 0.65,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Set1(), // startSet_1 화면으로 전환
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDFDFDF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, screenWidth * 0.08, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/person.png',
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                      ),
                      Expanded(
                        child: Text(
                          'Guest',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.04,
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
    );
  }
}
