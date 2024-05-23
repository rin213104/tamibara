import 'dart:async';
import 'package:flutter/material.dart';

class TimerModel extends ChangeNotifier {
  int maxSeconds = 3600; // 기본값은 3600초 (1시간)으로 설정
  int seconds = 0; // 남은 시간을 관리하는 변수
  int elapsedSeconds = 0; // 경과 시간을 관리하는 변수

  Timer? _timer;

  void setMaxSeconds(int newMaxSeconds) {
    maxSeconds = newMaxSeconds;
    seconds = newMaxSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    notifyListeners();
  }

  void startTimer({bool reset = true}) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    if (reset) {
      seconds = maxSeconds;
      elapsedSeconds = 0; // 경과 시간을 초기화
    }

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (elapsedSeconds < maxSeconds) {
        seconds--;
        elapsedSeconds++;
        notifyListeners();
      } else {
        _timer!.cancel();
      }
    });
    notifyListeners();
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      seconds = maxSeconds;
      elapsedSeconds = 0; // 경과 시간을 초기화
    }
    _timer?.cancel();
    notifyListeners();
  }

  void resetTimer() {
    seconds = maxSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    notifyListeners();
  }

  bool get isRunning => _timer != null && _timer!.isActive;
}
