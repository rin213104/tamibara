import 'package:flutter/material.dart';
import '../widget/to_do_card.dart';
import '../screen/to_do_list_screen.dart';

class GamingDataModel extends ChangeNotifier {
  int _EXP = 0;

  int get EXP => _EXP;

  void increaseCheckedEXP() { // 체크박스 선택 시 EXP 증가
    _EXP += 10;
    print("===================${_EXP}++++++++++++++++++++");
    notifyListeners();
  }

  void decreaseEXP() {
    if (_EXP > 0) {
      _EXP -= 10;
      print("===================${_EXP}++++++++++++++++++++");
      notifyListeners();
    }
  }

}