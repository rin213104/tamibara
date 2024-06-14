import 'package:flutter/material.dart';

class SelectedTodoModel with ChangeNotifier {
  String? _selectedTodoTitle;

  String? get selectedTodoTitle => _selectedTodoTitle;

  void setSelectedTodoTitle(String title) {
    _selectedTodoTitle = title;
    notifyListeners();
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/rin213104
