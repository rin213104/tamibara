import 'dart:async';
import 'package:flutter/material.dart';
import '../widget/to_do_card.dart';

class ToDoDataModel extends ChangeNotifier {
  DateTime _selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  int _selectedDuration = 0;
  late ToDoCard newToDo;
  List<ToDoCard> ToDoList = [];

  DateTime get selectedDate => _selectedDate;
  int get selectedDuration => _selectedDuration;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedDuration(int duration) {
    _selectedDuration = duration;
    notifyListeners();
  }

  void addNewToDoCard(ToDoCard newToDoCard) {
    //ToDoList.add(newToDoCard);
    //ToDoList.sort((a, b) => a.Date.compareTo(b.Date));
    newToDo = newToDoCard;
    notifyListeners();
  }

  /*void removeToDoById(String id) {
    ToDoList.removeWhere((todo) => todo.Id == id);
    int index = ToDoList.indexWhere((todo) => todo.Id == id);
    ToDoList[index].isChecked = false;
    notifyListeners();
  }

   */

}


