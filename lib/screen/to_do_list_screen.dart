import 'package:flutter/material.dart';
import 'package:timer/action/gaming_data_model.dart';
import '../widget/to_do_card.dart';
import '../const/colors.dart';
import '../screen/add_to_do_screen.dart';
import '../screen/edit_to_do_screen.dart';
import '../shared/menu_bottom.dart';
import 'package:provider/provider.dart';
import '../action/todo_data_model.dart';
import 'package:fluttertoast/fluttertoast.dart'; // 토스트 알림을 위해 추가
import 'dart:math'; // 랜덤 메시지를 위해 추가

class ToDoScreen extends StatefulWidget { //투두 리스트 화면
  final List<ToDoCard> ToDoList = [];

  ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _setToDoScreenState();
}

class _setToDoScreenState extends State<ToDoScreen> {
  final List<String> _congratulatoryMessages = [ // 축하 메시지 리스트 추가
    "목표를 달성하셨네요!\n정말 대단해요!",
    "잘했어요!\n꾸준한 모습이 좋아요!",
    "목표 달성!\n보람이 느껴지나요?",
    "대단해요!\n앞으로도 계속 이렇게 해봐요!",
    "목표 달성 완료!\n꾸준히 한다면 더 큰 목표도 이룰 수 있을 거예요!",
    "정말 잘했어요!\n열심히 하셨네요!",
    "수고했어요!\n앞으로도 열심히 해봐요!"
  ];

  /*
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removePastTodos();
    });
  }

   */

  void _removePastTodos() { // 현재 날짜를 기준으로 지난 할 일들을 삭제
    var GamingData = Provider.of<GamingDataModel>(context, listen: false);
    //print("removePastTodos,,,,,,,,,,,,,,,,,,,,,");

    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    int initialLength = widget.ToDoList.length;
    setState(() {
      widget.ToDoList.removeWhere((todo) => todo.Date.isBefore(startOfDay));
    });
    int removedCount = initialLength - widget.ToDoList.length;

    for (int i = 0; i < removedCount; i++) {
      GamingData.decreaseEXP(); // 지난 할 일 삭제 시 삭제된 카드만큼 경험치 -10씩
    }
  }

  void _handleToDoChecked(bool isChecked, int index) {
    setState(() {
      widget.ToDoList[index].isChecked = isChecked; // 상태 업데이트
    });
    if (isChecked) {
      Future.delayed(Duration(milliseconds: 100), () { // 상태 업데이트 후 약간의 딜레이를 줌
        setState(() {
          widget.ToDoList.removeAt(index);
        });
        _showRandomToast();  // 체크박스 상태 변경 시 랜덤 메시지 출력
        Provider.of<GamingDataModel>(context, listen: false).increaseCheckedEXP();  // 체크 박스 상태 변경 시 경험치 증가
      });
    }
  }

  void _ToDoDelete(index) {
    setState(() {
      widget.ToDoList.removeAt(index);
    });
  }

  Future<void> _ToDoEdit(int index) async {
    Provider.of<ToDoDataModel>(context, listen: false).setSelectedDate(widget.ToDoList[index].Date);
    Provider.of<ToDoDataModel>(context, listen: false).setSelectedDuration(widget.ToDoList[index].DurationTime);
    final editResults = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditToDo(todo: widget.ToDoList[index])),
    );

    if (editResults != null) {
      setState(() {
        ToDoCard updatedToDo = editResults[0];
        widget.ToDoList[index] = updatedToDo;
        widget.ToDoList.sort((a, b) => a.Date.compareTo(b.Date));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var ToDoData = Provider.of<ToDoDataModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removePastTodos();
    });

    return Scaffold(
      appBar: ToDoAppbar(),
      body: Container(
        color: PRIMARY_COLOR,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: widget.ToDoList.isEmpty
              ? SizedBox.expand()
              : ListView.builder(
            itemCount: widget.ToDoList.length,
            itemBuilder: (context, index) {
              bool showDateDivider = index == 0 ||
                  widget.ToDoList[index].Date != widget.ToDoList[index - 1].Date;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showDateDivider) ...[
                    SizedBox(height: 10),
                    Text(
                      '${widget.ToDoList[index].Date.year}.${widget.ToDoList[index].Date.month}.${widget.ToDoList[index].Date.day}',
                      style: TextStyle(
                        color: TEXT_COLOR,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Divider(
                      thickness: 1.3,
                      color: TEXT_COLOR,
                    ),
                    SizedBox(height: 10),
                  ],
                  ToDoCard(
                    Id: widget.ToDoList[index].Id,
                    Title: widget.ToDoList[index].Title,
                    Date: widget.ToDoList[index].Date,
                    DurationTime: widget.ToDoList[index].DurationTime,
                    Memo: widget.ToDoList[index].Memo,
                    isChecked: widget.ToDoList[index].isChecked,
                    onChecked: (isChecked) => _handleToDoChecked(isChecked, index),
                    onCancel: () => _ToDoDelete(index),
                    onEdit: () {
                      _ToDoEdit(index);
                    },
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFBBD9D6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        onPressed: () async {
          ToDoData.setSelectedDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
          ToDoData.setSelectedDuration(0);
          final results = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddToDo()),
          );

          if (results != null) {
            final List<ToDoCard> newToDoList = results;
            setState(() {
              widget.ToDoList.addAll(newToDoList);
              widget.ToDoList.sort((a, b) => a.Date.compareTo(b.Date));
            });
          }
        },
        child: Icon(Icons.add, color: TEXT_COLOR),
      ),
      bottomNavigationBar: MenuBottom(),
    );
  }

  // 랜덤 메시지를 표시하는 함수 추가
  void _showRandomToast() {
    final random = Random();
    final message = _congratulatoryMessages[random.nextInt(_congratulatoryMessages.length)];
    _showToast(message);
  }

  // 토스트 알림을 위한 함수 추가
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }
}

AppBar ToDoAppbar() {
  return AppBar(
    backgroundColor: PRIMARY_COLOR,
    title: Text(
      '목표 리스트',
      style: TextStyle(
        color: TEXT_COLOR,
        fontWeight: FontWeight.w700,
      ),
    ),
    centerTitle: false,
  );
}