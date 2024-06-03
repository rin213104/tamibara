import 'package:flutter/material.dart';
import '../screen/timerAnalog.dart';
import '../screen/timerDigital.dart';
import '../screen/timerGame.dart';

class TimerSlideExample extends StatefulWidget {
  final String? selectedImage;
  final int duration;

  TimerSlideExample({this.selectedImage, required this.duration});

  @override
  TimerSlideExampleState createState() => TimerSlideExampleState();
}

class TimerSlideExampleState extends State<TimerSlideExample> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          TimerAnalogPage(duration: widget.duration), // 아날로그 타이머 페이지
          TimerDigitalPage(duration: widget.duration), // 디지털 타이머 페이지
          TimerGamePage(duration: widget.duration), // 타이머 게임 페이지
        ],
      ),
    );
  }
}
