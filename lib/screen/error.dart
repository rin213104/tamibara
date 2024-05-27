import 'package:asd/shared/menu_bottom.dart';
import 'package:flutter/material.dart';

class errorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffD3F3EF),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage(
                      'lib/images/카피바라 성년.png',
                    ),
                    height: 100,
                  ),
                ),
                Text(
                  '일시적 오류로 서비스에 접속할 수 없습니다.\n잠시 후 다시 접속해 주세요.',
                  style: TextStyle(
                    color: Color(0xff5A715C),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}