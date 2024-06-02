import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import  '../screen/to_do_list_screen.dart';
import '../action/gaming_data_model.dart';
import 'package:provider/provider.dart';

// 타이머 종료 시 토스트 알림 메시지 리스트
List<String> toastMessages = [
  '대단해요! 목표 시간을 다 채웠어요!',
  '멋져요! 시간을 알차게 사용했어요!',
  '잘했어요! 목표 시간 달성!',
  '축하합니다! 목표 시간을 모두 채웠네요!',
  '훌륭해요! 목표 시간을 완수했어요!',
  '우와! 목표 시간을 다 채웠어요!',
  '잘했어요! 목표에 가까워졌어요!',
  '멋져요! 시간 관리를 잘했어요!',
  '훌륭합니다! 목표 시간을 모두 소화했어요!',
  '대단해요!'
];

// 타이머 모델
class TimerModel extends ChangeNotifier {
  int maxSeconds = 3600; // 기본값: 3600초 (1시간)으로 설정
  int seconds = 0; // 남은 시간을 관리하는 변수
  int elapsedSeconds = 0; // 경과 시간을 관리하는 변수
  String? originalImage; // 원래 이미지 경로를 저장
  String? modifiedImage; // 변경된 이미지 경로를 저장

  Timer? _timer;
  BuildContext? _context; // context를 저장할 변수

  void setMaxSeconds(int newMaxSeconds) {
    maxSeconds = newMaxSeconds;
    seconds = newMaxSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    notifyListeners();
  }

  // context를 저장할 변수
  void setContext(BuildContext context) {
    _context = context;
  }

  // 타이머 시작
  void startTimer({bool reset = true}) {
    if (_timer != null && _timer!.isActive) {
      modifiedImage = originalImage;
      _timer!.cancel();
    }
    if (reset) {
      seconds = maxSeconds;
      elapsedSeconds = 0; // 경과 시간을 초기화
      modifiedImage = originalImage; // 이미지 복원
    }

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (elapsedSeconds < maxSeconds) {
        seconds--;
        elapsedSeconds++;
        notifyListeners();
      } else {
        _timer!.cancel();
        onTimerEnd(); // 타이머 종료시 이미지 변경
      }
    });
    notifyListeners();
  }

  // 타이머 정지
  void stopTimer({bool reset = true}) {
    if (reset) {
      seconds = maxSeconds;
      elapsedSeconds = 0; // 경과 시간을 초기화
      modifiedImage = originalImage; // 이미지 복원
    }
    _timer?.cancel();
    notifyListeners();
  }

  // 타이머 포기
  void resetTimer() {
    seconds = maxSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    modifiedImage = originalImage; // 이미지 복원
    notifyListeners();
  }

  bool get isRunning => _timer != null && _timer!.isActive;

  // 타이머 종료 시 이미지 변경 함수
  void changeImageOnTimerEnd() {
    if (originalImage != null) {
      if (originalImage!.contains('곰돌기본채색.png')) {
        modifiedImage = 'assets/images/bear/곰돌신남채색.png';
      } else if (originalImage!.contains('카피바라성년.png')) {
        modifiedImage = 'assets/images/capybara/카피바라기쁨.png';
      } else if (originalImage!.contains('냥돌기본채색.png')) {
        modifiedImage = 'assets/images/cat/냥돌신남채색.png';
      }
      notifyListeners();
    }
  }

  // 타이머 종료 시
  void onTimerEnd() {
    if (!_timer!.isActive) { // 타이머가 이미 종료되었는지 확인
      changeImageOnTimerEnd();    // 타이머 완료 이미지 변경
      showRandomToastMessage(); // 토스트 알림

      if (_context != null) {
        // GamingDataModel을 Provider에서 가져옴
        //final gamingDataModel = Provider.of<GamingDataModel>(_context!, listen: false);
        //gamingDataModel.increaseTimerEXP(maxSeconds);
        Provider.of<GamingDataModel>(_context!, listen: false).increaseTimerEXP(maxSeconds);
      }

      // 10초 후 ToDoScreen으로 페이지 전환
      Future.delayed(Duration(seconds: 6), () {
        if (_context != null) {
          Navigator.push(
            _context!,
            MaterialPageRoute(
              builder: (context) => ToDoScreen(),
            ),
          );
        }
      });
    }

  }

  void resetImage() {
    modifiedImage = originalImage; // modifiedImage를 originalImage로 복원
    notifyListeners();
  }

  void setOriginalImage(String imagePath) {
    originalImage = imagePath;
    // modifiedImage = imagePath; // originalImage와 modifiedImage를 동일하게 설정
    notifyListeners();
  }

  String? getCurrentImage() {
    return modifiedImage ?? originalImage;
  }

  // 랜덤 토스트 알림 메시지 표시
  void showRandomToastMessage() {
    final random = Random();
    final selectedMessage = toastMessages[random.nextInt(toastMessages.length)];

    Fluttertoast.showToast(
      msg: selectedMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }
}