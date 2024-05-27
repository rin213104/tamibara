import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer/shared/menu_bottom.dart';
import 'package:timer/widget/button_widget.dart';
import 'package:timer/widget/gradient_widget.dart';
import '../action/timerModel.dart'; // TimerModel 경로 확인
import '../action/selectedImageModel.dart';
import '../const/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerModel()),
        ChangeNotifierProvider(create: (_) => SelectedImageModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TimerAnalogPage(), // 기본 이미지 경로 설정
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedImageModel = Provider.of<SelectedImageModel>(context, listen: false);
      final timerModel = Provider.of<TimerModel>(context, listen: false);
      if (selectedImageModel.selectedImage != null) {
        timerModel.setOriginalImage(selectedImageModel.selectedImage!); // 선택된 이미지를 TimerModel에 설정
      }
    });
  }

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

  Widget buildTopBar() => Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    height: MediaQuery.of(context).size.height / 8,
    alignment: Alignment.center,
    color: PRIMARY_COLOR,
    child: buildDateText(),
  );

  Widget buildDateText() {
    final now = DateTime.now();
    final formattedDate = DateFormat('MM.dd.EEE').format(now);

    return Text(
      formattedDate,
      style: TextStyle(
        color: TIMER_COLOR,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // 타이머 버튼
  Widget buildButton() {
    return Consumer2<TimerModel, SelectedImageModel>(
      builder: (context, timer, selectedImageModel, child) {
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
                  // 타이머를 다시 시작할 때 원래 이미지로 복원
                  if (timer.originalImage != null) {
                    timer.resetImage(); // modifiedImage를 originalImage로 복원
                    selectedImageModel.setSelectedImage(timer.originalImage!);
                  }
                  timer.startTimer(reset: false);
                }
              },
            ),
            const SizedBox(width: 12),
            ButtonWidget(
              text: 'Reset',
              onClicked: () {
                timer.resetImage(); // modifiedImage를 originalImage로 복원
                if (timer.originalImage != null) {
                  selectedImageModel.setSelectedImage(timer.originalImage!);
                }
                timer.resetTimer();
              },
            ),
          ],
        )
            : ButtonWidget(
          text: 'Start Timer!',
          onClicked: () {
            if (timer.originalImage != null) {
              selectedImageModel.setSelectedImage(timer.originalImage!); // 원래 이미지로 복원
            }
            timer.startTimer();
          },
        );
      },
    );
  }

  Widget buildTimer() {
    return Consumer2<TimerModel, SelectedImageModel>(
      builder: (context, timer, selectedImageModel, child) {
        double progressValue = 0; // 기본 값을 0으로 설정
        if (timer.maxSeconds > 0) { // maxSeconds가 0이 아닐 때만 계산
          progressValue = timer.seconds / timer.maxSeconds;
        }

        // 타이머가 종료되면 onTimerEnd 함수 호출
        if (timer.seconds == 0 && timer.isRunning) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onTimerEnd(context);
          });
        }

        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 350,
                child: CircularProgressIndicator(  // 타이머 원형 진행 바
                  value: progressValue, // 수정된 값 사용
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  backgroundColor: PROGRESSBAR_COLOR,
                  strokeWidth: 20,
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
                        color: TIMER_COLOR,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Image.asset(
                      timer.getCurrentImage() ?? 'lib/images/capybara/카피바라성년.png',
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

  // 타이머 종료 시 이미지 변경 함수
  void changeImageOnTimerEnd(BuildContext context) {
    final timerModel = Provider.of<TimerModel>(context, listen: false);
    final selectedImageModel = Provider.of<SelectedImageModel>(context, listen: false);
    timerModel.changeImageOnTimerEnd();
    selectedImageModel.setSelectedImage(timerModel.getCurrentImage()!);
  }

  // 타이머 종료 시 이미지 변경 함수 호출
  void onTimerEnd(BuildContext context) {
    changeImageOnTimerEnd(context);
  }

  // 페이지 1/2 표시
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
