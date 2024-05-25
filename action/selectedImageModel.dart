import 'package:flutter/foundation.dart';

// 선택된 캐릭터 저장
class SelectedImageModel extends ChangeNotifier {
  String? _selectedImage;

  String? get selectedImage => _selectedImage;

  void setSelectedImage(String image) {
    _selectedImage = image;
    notifyListeners();
  }
}
