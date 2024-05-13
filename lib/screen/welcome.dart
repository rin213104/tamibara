import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/startSet_3.dart';
import '../const/colors.dart';

void main() {
  runApp(WelcomeScreen());
}

class WelcomeScreen extends StatelessWidget {
  final String? selectedImage;

  WelcomeScreen({Key? key, this.selectedImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 70, 130, 0),
                        child: Text(
                          '준비가 끝났습니다!',
                          style: TextStyle(
                            color: TEXT_COLOR,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Text(
                          '이제 목표를 향해 달려 볼까요?',
                          style: TextStyle(
                            color: TEXT_COLOR,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: selectedImage != null
                            ? Image.asset(
                          selectedImage!,
                          width: 250,
                          height: 250,
                        )
                            : SizedBox(), // 선택된 이미지가 없으면 빈 SizedBox 반환
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}