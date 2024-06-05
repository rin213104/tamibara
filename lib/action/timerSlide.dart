import 'package:flutter/material.dart';
import '../screen/timerAnalog.dart';
import '../screen/timerDigital.dart';
import '../screen/timerGame.dart';

// 타이머 슬라이드: timerAnalog, timerDigital 페이지 이동
class timerSlideExample extends StatefulWidget {
  final String? selectedImage;
  timerSlideExample({this.selectedImage});

  @override
  timerSlideExampleState createState() => timerSlideExampleState();  // 페이지 컨트롤러 설정
}

class timerSlideExampleState extends State<timerSlideExample> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          TimerAnalogPage(),  // 아날로그 타이머 페이지
          TimerDigitalPage(), // 디지털 타이머 페이지
          TimerGamePage()     // 타이머 게임 페이지
        ],
      ),
    );
  }
}
