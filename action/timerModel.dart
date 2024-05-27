import 'dart:async';
import 'package:flutter/material.dart';

// 타이머 모델
class TimerModel extends ChangeNotifier {
  int maxSeconds = 3600; // 기본값: 3600초 (1시간)으로 설정
  int seconds = 0; // 남은 시간을 관리하는 변수
  int elapsedSeconds = 0; // 경과 시간을 관리하는 변수
  String? originalImage; // 원래 이미지 경로를 저장
  String? modifiedImage; // 변경된 이미지 경로를 저장

  Timer? _timer;

  void setMaxSeconds(int newMaxSeconds) {
    maxSeconds = newMaxSeconds;
    seconds = newMaxSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    notifyListeners();
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

  // 타이머 리셋
  void resetTimer() {
    seconds = maxSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    modifiedImage = originalImage; // 이미지 복원
    notifyListeners();
  }

  bool get isRunning => _timer != null && _timer!.isActive;

  // 타이머 종료 시 이미지 변경 함수
  void changeImageOnTimerEnd() {
    // 현재 선택된 이미지를 변경하는 로직을 구현합니다.
    if (originalImage != null) {
      if (originalImage!.contains('곰돌기본채색.png')) {
        modifiedImage = 'lib/images/bear/곰돌신남채색.png';
      } else if (originalImage!.contains('카피바라성년.png')) {
        modifiedImage = 'lib/images/capybara/카피바라기쁨.png';
      } else if (originalImage!.contains('냥돌기본채색.png')) {
        modifiedImage = 'lib/images/cat/냥돌신남채색.png';
      }
    }
    notifyListeners();
  }

  // 타이머 종료 시 이미지 변경 호출
  void onTimerEnd() {
    changeImageOnTimerEnd();
  }

  void setOriginalImage(String imagePath) {
    originalImage = imagePath;
    modifiedImage = imagePath; // originalImage와 modifiedImage를 동일하게 설정
    notifyListeners();
  }

  String? getCurrentImage() {
    return modifiedImage ?? originalImage;
  }

  void resetImage() {
    modifiedImage = originalImage; // modifiedImage를 originalImage로 복원
    notifyListeners();
  }
}
