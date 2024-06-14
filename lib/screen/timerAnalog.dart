import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import '../shared/menu_bottom.dart';
import '../widget/button_widget.dart';
import '../widget/gradient_widget.dart';
import '../action/timerModel.dart'; // TimerModel 경로 확인
import '../action/selectedImageModel.dart';
import '../const/colors.dart';
import '../screen/to_do_list_screen.dart';
=======
import 'package:timer/shared/menu_bottom.dart';
import 'package:timer/widget/button_widget.dart';
import 'package:timer/widget/gradient_widget.dart';
import '../action/timerModel.dart'; // TimerModel 경로 확인
import '../action/selectedImageModel.dart';
import '../const/colors.dart';
import 'to_do_list_screen.dart';
>>>>>>> origin/rin213104

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
<<<<<<< HEAD
        home: TimerAnalogPage(), // 기본 이미지 경로 설정
=======
        home: TimerAnalogPage(title: 'Your Timer Title'), // 기본 이미지 경로 설정
>>>>>>> origin/rin213104
      ),
    );
  }
}

class TimerAnalogPage extends StatefulWidget {
<<<<<<< HEAD
=======
  final String title;
  TimerAnalogPage({required this.title});

>>>>>>> origin/rin213104
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
                    buildDotsIndicator(), // 슬라이드 dot 표현 부분
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

  // 타이머 날짜 -> 타이머 목표 타이틀
  Widget buildDateText() {
<<<<<<< HEAD
    final now = DateTime.now();
    final formattedDate = DateFormat('MM.dd.EEE').format(now);

    return Text(
      formattedDate,
      style: TextStyle(
        color: TIMER_COLOR,
        fontSize: 18,
=======
    return Text(
      widget.title, // title로 변경
      style: TextStyle(
        color: TIMER_COLOR,
        fontSize: 20,
>>>>>>> origin/rin213104
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // 추가한 부분 11: 10
  void onTimerEnd(BuildContext context) {
    final timerModel = Provider.of<TimerModel>(context, listen: false);
    final selectedImageModel = Provider.of<SelectedImageModel>(context, listen: false);
    timerModel.changeImageOnTimerEnd();
    selectedImageModel.setSelectedImage(timerModel.getCurrentImage()!);
  }

  // 타이머 버튼
  Widget buildButton() {
    return Consumer2<TimerModel, SelectedImageModel>(
      builder: (context, timer, selectedImageModel, child) {
        final isRunning = timer.isRunning;
        final isCompleted = timer.seconds == timer.maxSeconds || timer.seconds == 0;

        if (timer.seconds == 0 && !isRunning) {
          // 타이머가 종료된 상태
          return ButtonWidget(
            text: '타이머 종료',
            onClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ToDoScreen(),
                ),
              );
            },
          );
        } else {
          return isRunning || !isCompleted
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: isRunning ? '중지' : '재시작',
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
                text: '포기',
                onClicked: () {
                  timer.stopTimer(reset: false);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('정말로 포기하시겠습니까?'),
                        content: Text('경험치를 받을 수 없게 됩니다'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              timer.startTimer(reset: false);
                            },
                            child: Text('다시진행'),
                          ),
                          TextButton(
                            onPressed: () {
                              timer.resetImage();
                              if (timer.originalImage != null) {
                                selectedImageModel.setSelectedImage(timer.originalImage!);
                              }
                              timer.resetTimer();
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ToDoScreen(),
                                ),
                              );
                            },
                            child: Text('포기'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          )
              : ButtonWidget(
            text: '타이머 시작',
            onClicked: () {
              if (timer.originalImage != null) {
                selectedImageModel.setSelectedImage(timer.originalImage!); // 원래 이미지로 복원
              }
              timer.startTimer();
            },
          );
        }
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
            timer.onTimerEnd();
          });
        }

<<<<<<< HEAD
        String? folder = selectedImageModel.selectedFolder;
=======
        String? folder = selectedImageModel.selectedFolder ?? selectedImageModel.selectedImage?.split('/')[2];
>>>>>>> origin/rin213104
        String image1 = 'assets/images/$folder/${folder}달림1.png';
        String image2 = 'assets/images/$folder/${folder}달림2.png';
        double imageSize = timer.isAnimating ? 80.0 : 80.0;

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
                      timer.isAnimating
                          ? (timer.isFirstImage ? image1 : image2)
                          : timer.getCurrentImage() ?? 'assets/images/capybara/카피바라성년.png',
                      width: imageSize,
                      height: imageSize,
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

  // 페이지 1/3 표시
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