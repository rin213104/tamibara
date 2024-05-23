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
        home: TimerDigitalPage(),
      ),
    );
  }
}

class TimerDigitalPage extends StatefulWidget {
  @override
  _TimerDigitalPageState createState() => _TimerDigitalPageState();
}

class _TimerDigitalPageState extends State<TimerDigitalPage> {
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
                    const SizedBox(height: 30), // 하단 여백을 주기 위해 추가
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

  Widget buildTopBar() => Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    height: MediaQuery.of(context).size.height / 8,
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
        final isCompleted = timer.seconds == timer.maxSeconds || timer.seconds == 0;

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
          progressValue = timer.elapsedSeconds / timer.maxSeconds;
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${timer.elapsedSeconds ~/ 60}:${(timer.elapsedSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Color(0xFF4D6058),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'lib/images/image.png',
              width: 80,
              height: 80,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              height: 15,
              child: LinearProgressIndicator(
                value: progressValue, // 수정된 값 사용
                valueColor: AlwaysStoppedAnimation(Color(0xFF5B9A90)), // 초록색으로 변경
                backgroundColor: Colors.white, // 배경색을 흰색으로 설정
              ),
            ),
          ],
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
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFAFCBBF),
          ),
        ),
      ],
    );
  }
}
