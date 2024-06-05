import 'package:flutter/foundation.dart';

// 선택된 캐릭터 저장
class SelectedImageModel extends ChangeNotifier {
  String? _selectedImage;
  String? _selectedFolder;

  String? get selectedImage => _selectedImage;
  String? get selectedFolder => _selectedFolder;

  void setSelectedImage(String image) {
    _selectedImage = image;
    _selectedFolder = image.split('/')[2]; // 상위 폴더 경로 저장
    notifyListeners();
  }
}
