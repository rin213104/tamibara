import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer/shared/menu_bottom.dart';
import 'package:timer/widget/button_widget.dart';
import 'package:timer/widget/gradient_widget.dart';
import '../action/timerModel.dart'; // TimerModel 경로 확인

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerModel(),
      child: MaterialApp(
        home: TimerAnalogPage(),
      ),
    );
  }
}

class TimerAnalogPage extends StatefulWidget {
  @override
  _TimerAnalogPageState createState() => _TimerAnalogPageState();
}

class _TimerAnalogPageState extends State<TimerAnalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTopBar(),
          Expanded(
            child: GradientWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTimer(), // Timer display widget
                    const SizedBox(height: 50),
                    buildButton(), // Timer control buttons
                    const SizedBox(height: 30),
                    buildDotsIndicator(), // 원형 동그라미 추가
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: MenuBottom(),
    );
  }

  Widget buildTopBar() =>
      Container(
        padding: EdgeInsets.only(top: MediaQuery
            .of(context)
            .padding
            .top),
        height: MediaQuery
            .of(context)
            .size
            .height / 8,
        alignment: Alignment.center,
        color: Color(0xFFD3F3EF),
        child: buildDateText(),
      );

  Widget buildDateText() {
    final now = DateTime.now();
    final formattedDate = DateFormat('MM.dd.EEE').format(now);

    return Text(
      formattedDate,
      style: TextStyle(
        color: Color(0xFF4D6058),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildButton() {
    return Consumer<TimerModel>(
      builder: (context, timer, child) {
        final isRunning = timer.isRunning;
        final isCompleted = timer.seconds == timer.maxSeconds ||
            timer.seconds == 0;

        return isRunning || !isCompleted
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              text: isRunning ? 'Pause' : 'Restart',
              onClicked: () {
                if (isRunning) {
                  timer.stopTimer(reset: false);
                } else {
                  timer.startTimer(reset: false);
                }
              },
            ),
            const SizedBox(width: 12),
            ButtonWidget(
              text: 'Reset',
              onClicked: () => timer.resetTimer(),
            ),
          ],
        )
            : ButtonWidget(
          text: 'Start Timer!',
          onClicked: () => timer.startTimer(),
        );
      },
    );
  }

  Widget buildTimer() {
    return Consumer<TimerModel>(
      builder: (context, timer, child) {
        double progressValue = 0; // 기본 값을 0으로 설정
        if (timer.maxSeconds > 0) { // maxSeconds가 0이 아닐 때만 계산
          progressValue = timer.seconds / timer.maxSeconds;
        }
        return SizedBox(
          width: 200, // 전체 크기 설정
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 350,
                child: CircularProgressIndicator(
                  value: progressValue, // 수정된 값 사용
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  backgroundColor: Color(0xFF5B9A90),
                  strokeWidth: 20, // 원형 진행 바의 두께를 조정
                ),
              ),
              Positioned(
                top: 30, // 원하는 y축 위치로 조정
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${timer.seconds ~/ 60}:${(timer.seconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Color(0xFF4D6058),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Image.asset(
                      'lib/images/image.png',
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFAFCBBF),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}