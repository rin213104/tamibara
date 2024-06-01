import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../action/timerModel.dart';
import 'package:provider/provider.dart';
import 'package:timer/action/timerSlide.dart';
import '../const/colors.dart';

class TimerSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '타이머 설정',
          style: TextStyle(
            color: TEXT_COLOR, // 제목 텍스트 색상 설정
            fontWeight: FontWeight.bold, // 텍스트의 굵기 설정
          ),
        ),
        backgroundColor: PRIMARY_COLOR, // 제목 배경색 설정
        elevation: 0,
      ),
      backgroundColor: PRIMARY_COLOR,
      body: Column(
        children: [
          SizedBox(height: 40),
          SetTime(), // 시간을 설정할 수 있는 위젯
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // 설정된 시간을 TimerModel에 전달하고 슬라이드 화면으로 이동
              final timerModel = Provider.of<TimerModel>(context, listen: false);
              timerModel.setMaxSeconds(SetTimeState.totalSeconds);
              timerModel.resetImage();
              timerModel.setContext(context); // context 설정
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => timerSlideExample(), // timerSlide 화면으로 전환
                ),
              );
            },
            child: Text(
              '설정 완료',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // 버튼 패딩 조정
              minimumSize: Size(150, 50), // 버튼 최소 크기 설정
              backgroundColor: BUTTON_COLOR,
            ),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularTimerButton(time: 15), // 15분 버튼
              CircularTimerButton(time: 30), // 30분 버튼
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularTimerButton(time: 50), // 50분 버튼
              CircularTimerButton(time: 60), // 1시간 버튼
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class SetTime extends StatefulWidget {
  const SetTime({Key? key}) : super(key: key);

  @override
  State<SetTime> createState() => SetTimeState();
}

class SetTimeState extends State<SetTime> {
  static int totalSeconds = 0;
  int hour = 0;  // 설정된 시간(시)
  int minute = 0;  // 설정된 시간(분)
  int second = 0;  // 설정된 시간(초)

  // 시간, 분, 초 리스트 생성
  List<int> minutes = List<int>.generate(60, (i) => i);
  List<int> hours = List<int>.generate(24, (i) => i);
  List<int> seconds = List<int>.generate(60, (i) => i);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.0),
        Expanded(
          flex: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0), // 원하는 가로 여백 설정
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.0), // 수직 패딩 설정
              ),
              onPressed: () async {
                // 시간 설정 팝업 창 열기
                await showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5, // 다이얼로그 높이 설정
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          backgroundColor: Colors.white,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '타이머 시간',
                                style: TextStyle(
                                  color: Color(0xFF6F867C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Divider(
                                thickness: 1.3,
                                color: Color(0xFF6F867C),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        height: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '시간',
                                                    style: TextStyle(
                                                      height: 0.1,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,), // 텍스트와 휠스크롤 사이 간격
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              flex: 8,
                                              child: ListWheelScrollView(
                                                overAndUnderCenterOpacity: 0.5,
                                                useMagnifier: true, // 확대경 사용 여부
                                                itemExtent: 30, // 아이템 크기
                                                onSelectedItemChanged: (i) {
                                                  setState(() {
                                                    hour = hours[i];
                                                  });
                                                },
                                                children: hours.map((e) => Text(e.toString())).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(   // 분 선택 휠
                                      child: Container(
                                        height: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '분',
                                                    style: TextStyle(
                                                      height: 0.1,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              flex: 8,
                                              child: ListWheelScrollView(
                                                overAndUnderCenterOpacity: 0.5,
                                                useMagnifier: true, // 확대경 사용 여부
                                                itemExtent: 30, // 아이템 크기
                                                onSelectedItemChanged: (i) {
                                                  setState(() {
                                                    minute = minutes[i];
                                                  });
                                                },
                                                children: minutes.map((e) => Text(e.toString())).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(  // 초 선택 휠
                                      child: Container(
                                        height: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '초',
                                                    style: TextStyle(
                                                      height: 0.1,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              flex: 8,
                                              child: ListWheelScrollView(
                                                overAndUnderCenterOpacity: 0.5,
                                                useMagnifier: true, // 확대경 사용 여부
                                                itemExtent: 30, // 아이템 크기
                                                onSelectedItemChanged: (i) {
                                                  setState(() {
                                                    second = seconds[i];
                                                  });
                                                },
                                                children: seconds.map((e) => Text(e.toString())).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            ButtonBar(
                              buttonPadding: EdgeInsets.symmetric(horizontal: 0),
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '취소',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      totalSeconds = hour * 3600 + minute * 60 + second;
                                    });
                                  },
                                  child: Text(
                                    '확인',
                                    style: TextStyle(
                                      color: Color(0xFF6F867C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${hour}시간',
                      style: TextStyle(
                        color: Color(0xFFB1B1B1),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 80.0),
                    Text(
                      '${minute}분',
                      style: TextStyle(
                        color: Color(0xFFB1B1B1),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 80.0),
                    Text(
                      '${second}초',
                      style: TextStyle(
                        color: Color(0xFFB1B1B1),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CircularTimerButton extends StatelessWidget {
  final int time;

  const CircularTimerButton({required this.time});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final totalSeconds = time * 60;
        final timerModel = Provider.of<TimerModel>(context, listen: false);
        timerModel.setMaxSeconds(totalSeconds);
        timerModel.resetImage();  // 이미지 리셋
        timerModel.setContext(context); // context 설정
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => timerSlideExample(), // timerSlide 화면으로 전환
          ),
        );
      },
      child: Container(
        width: 80, // 버튼의 너비를 증가
        height: 80, // 버튼의 높이를 증가
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFB5E6D1),
        ),
        child: Center(
          child: Text(
            '${time}분',
            style: TextStyle(
              color: Color(0xFF4D6058),
              fontWeight: FontWeight.bold,
              fontSize: 20, // 텍스트 크기를 증가
            ),
          ),
        ),
      ),
    );
  }
}