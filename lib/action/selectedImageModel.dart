import 'package:flutter/foundation.dart';
<<<<<<< HEAD
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> origin/rin213104

// 선택된 캐릭터 저장
class SelectedImageModel extends ChangeNotifier {
  String? _selectedImage;
  String? _selectedFolder;

  String? get selectedImage => _selectedImage;
  String? get selectedFolder => _selectedFolder;

  void setSelectedImage(String image) {
    _selectedImage = image;
    _selectedFolder = image.split('/')[2]; // 상위 폴더 경로 저장
<<<<<<< HEAD
=======
    saveSelectedImage(image, _selectedFolder!); // 이미지 저장
    notifyListeners();
  }

  // SharedPreferences 함수 추가 - 이미지랑 폴더 저장
  Future<void> saveSelectedImage(String imagePath, String folder) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedImage', imagePath);
    await prefs.setString('selectedFolder', folder);
  }

  Future<String?> getSelectedImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedImage');
  }

  Future<String?> getSelectedFolder() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedFolder');
  }

  Future<void> initializeSelectedImage() async {
    _selectedImage = await getSelectedImage();
    _selectedFolder = await getSelectedFolder();
>>>>>>> origin/rin213104
    notifyListeners();
  }
}
