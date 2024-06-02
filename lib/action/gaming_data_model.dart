import 'package:flutter/material.dart';
import '../widget/to_do_card.dart';
import '../screen/to_do_list_screen.dart';

class GamingDataModel extends ChangeNotifier {
  double _EXP = 0;

  double get EXP => _EXP;

  void increaseCheckedEXP() { // 체크박스 선택 시 EXP 증가
    _EXP += 10;
    //print("===================${_EXP}++++++++++++++++++++");
    notifyListeners();
  }

  void increaseTimerEXP(int duration) {
    duration = duration ~/ 60;
    double temp = duration * 0.25;
    _EXP += temp;
    //print("===================${_EXP}++++++++++++++++++++");
    notifyListeners();
  }

  void decreaseEXP() { // EXP 감소
    if (_EXP > 0) {
      _EXP -= 10;
      //print("===================${_EXP}++++++++++++++++++++");
      notifyListeners();
    }
  }

}