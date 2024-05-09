import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/startSet_2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: Scaffold (
        body: Container (
          decoration: BoxDecoration ( // 배경 색상 설정
            color: Color(0xFFD3F3EF),
          ),
          child: Column (
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 70, 178, 0), // 텍스트1 패딩 값 설정
                        child: Text(
                          "환영합니다!",
                          style: TextStyle(
                            color: Color(0xFF6F867C), // 텍스트1 색상
                            fontSize: 28, // 텍스트1 크기
                            fontWeight: FontWeight.w900, // 텍스트1 제일 굵게
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0), // 텍스트2 패딩 값 설정
                          child: Text(
                            "당신의 목표를 알려 주세요!",
                            style: TextStyle(
                              color: Color(0xFF6F867C), // 텍스트2 색상
                              fontSize: 28, // 텍스트2 크기
                              fontWeight: FontWeight.w900, // 텍스트2 제일 굵게
                            ),
                          )
                      ),
                      // SizedBox(height: 2),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                        child: Image.asset(
                          'assets/images/스크린샷 2024-05-02 16.08.09.png',
                          width: 350,
                          height: 90,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, // 텍스트 버튼 중앙 배치
                        children: [
                          SizedBox(
                            width: 350, // 텍스트 버튼1 크기 설정
                            height: 60,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NickNameScreen(),
                                  ),
                                );
                              }, // 버튼 눌렀을 때 호출할 콜백 함수
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xffF7FFFD), // 텍스트 버튼1 배경 색상
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20), // 모서리 둥글기 설정
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center, // 폰트 크기가 다른 텍스트 두 개를 하나의 버튼에 배치
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      '장기적인 목표',
                                      style: TextStyle(
                                        color: Color(0xff6F867C),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Padding(
                                    padding: EdgeInsets.only(right: 90), // 오른쪽 여백 값을 조절해서 왼쪽 정렬
                                    child: Text(
                                      '- 시험, 자격증 등',
                                      style: TextStyle(
                                        color: Color(0xff6F867C),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20), // 위 버튼 사이의 여백
                          SizedBox( // 텍스트 버튼2 크기 설정
                              width: 350,
                              height: 60,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NickNameScreen(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xffF7FFFD),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // 폰트 크기가 다른 텍스트 두 개 하나의 버튼에 배치
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5), // 텍스트 왼쪽 여백 값 설정
                                      child: Text(
                                        '단기적인 목표',
                                        style: TextStyle(
                                          color: Color(0xff6F867C),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Padding(
                                      padding: EdgeInsets.only(right: 70), // 오른쪽 여백 값 조절해서 왼쪽 정렬
                                      child: Text(
                                        '- 일상 공부, 할 일 등',
                                        style: TextStyle(
                                          color: Color(0xff6F867C),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                              ),
                            )
                          )
                        ],
                      )
                    ], // children
                  )
                ], // children
              )
            ],
          ),
        ),
      ),
    );
  }
}
