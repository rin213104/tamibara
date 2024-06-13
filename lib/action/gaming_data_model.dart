import 'package:flutter/material.dart';
import '../widget/to_do_card.dart';
import '../screen/to_do_list_screen.dart';
import '../database/local_exp.dart';  // ExperienceStorage 가져오기

class GamingDataModel extends ChangeNotifier {
  final ExperienceStorage _experienceStorage = ExperienceStorage(); // ExperienceStorage 인스턴스 생성
  late double _EXP;

  double get EXP => _EXP;

  GamingDataModel() {
    loadExperience();
  }

  Future<void> loadExperience() async {
    _EXP = await _experienceStorage.getExperience();
    notifyListeners();
  }

  Future<void> _saveExperience() async {
    await _experienceStorage.saveExperience(_EXP);
  }

  void increaseCheckedEXP() { // 체크박스 선택 시 EXP 증가
    _EXP += 100;
    _saveExperience();
    //print("===================${_EXP}++++++++++++++++++++");
    notifyListeners();
  }

  void increaseTimerEXP(int duration) { // 타이머 종료 시 분당 경험치 +25
    duration = duration ~/ 60;
    double temp = duration * 25;
    _EXP += temp;
    _saveExperience();
    //print("===================${_EXP}++++++++++++++++++++");
    notifyListeners();
  }

  void decreaseEXP() { // EXP 감소
    if (_EXP > 0) {
      _EXP -= 100;
      _saveExperience();
      //print("===================${_EXP}++++++++++++++++++++");
      notifyListeners();
    }
  }

}