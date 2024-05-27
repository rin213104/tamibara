import 'package:flutter/material.dart';

class nickNameProvider with ChangeNotifier {
  String _nickname = '';

  String get nickname => _nickname;

  void setNickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }
}
