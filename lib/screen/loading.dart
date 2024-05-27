import 'package:asd/const/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Stack을 사용하여 이미지 겹치기
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: Image(
                        image: AssetImage(
                          'lib/images/카피바라 성년.png',
                        ),
                      ),
                    ),
                    SpinKitRing(
                      color: Color(0xff5B9A90),
                      size: 120,
                      duration: Duration(seconds: 2),
                    ),
                  ],
                ),
                SizedBox(height: 10), // 로딩 이미지와 텍스트 사이 간격 조절
                Text(
                  'loading...',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}