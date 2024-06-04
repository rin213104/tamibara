import 'package:flutter/material.dart';
import '../action/gaming_data_model.dart';
import '../widget/to_do_card.dart';
import '../const/colors.dart';
import '../screen/add_to_do_screen.dart';
import '../screen/edit_to_do_screen.dart';
import '../shared/menu_bottom.dart';
import 'package:provider/provider.dart';
import '../action/todo_data_model.dart';
import '../widget/customToast.dart'; // 토스트 메시지
import 'dart:math'; // 랜덤 메시지를 위해 추가
import '../database/database_helper.dart'; // 데이터베이스 헬퍼 추가

class ToDoScreen extends StatefulWidget {
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

  final DatabaseHelper dbHelper = DatabaseHelper(); // 데이터베이스 헬퍼 인스턴스 추가

  @override
  void initState() {
    super.initState();
    _loadTodos(); // 초기 로딩 시 데이터베이스에서 할 일 목록 불러오기
  }

  void _loadTodos() async {
    await dbHelper.deletePastTodos(); // 지난 할 일 삭제
    final List<Todo> loadedTodos = await dbHelper.todos();
    setState(() {
      widget.ToDoList.clear();
      widget.ToDoList.addAll(loadedTodos.map((todo) => ToDoCard(
        Id: todo.id,
        Title: todo.title,
        Date: todo.date,
        DurationTime: todo.durationTime,
        Memo: todo.memo,
        isChecked: todo.isChecked,
        onChecked: (isChecked) => _handleToDoChecked(isChecked, widget.ToDoList.indexWhere((element) => element.Id == todo.id)),
        onCancel: () => _ToDoDelete(widget.ToDoList.indexWhere((element) => element.Id == todo.id)),
        onEdit: () => _ToDoEdit(widget.ToDoList.indexWhere((element) => element.Id == todo.id)),
      )));
    });
  }

  /*void _removePastTodos() {
    var GamingData = Provider.of<GamingDataModel>(context, listen: false);
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

   */

  void _handleToDoChecked(bool isChecked, int index) {
    setState(() {
      widget.ToDoList[index].isChecked = isChecked; // 상태 업데이트
    });
    if (isChecked) {
      Future.delayed(Duration(milliseconds: 100), () { // 상태 업데이트 후 약간의 딜레이를 줌
        setState(() {
          dbHelper.deleteTodo(widget.ToDoList[index].Id); // 데이터베이스에서 할 일 삭제
          widget.ToDoList.removeAt(index);
        });
        _showRandomToast();  // 체크박스 상태 변경 시 랜덤 메시지 출력
        Provider.of<GamingDataModel>(context, listen: false).increaseCheckedEXP();  // 체크 박스 상태 변경 시 경험치 증가
      });
    } else {
      dbHelper.updateTodo(Todo( // 데이터베이스에서 할 일 업데이트
        id: widget.ToDoList[index].Id,
        title: widget.ToDoList[index].Title,
        date: widget.ToDoList[index].Date,
        durationTime: widget.ToDoList[index].DurationTime,
        memo: widget.ToDoList[index].Memo,
        isChecked: isChecked,
      ));
    }
  }

  void _ToDoDelete(index) {
    setState(() {
      dbHelper.deleteTodo(widget.ToDoList[index].Id); // 데이터베이스에서 할 일 삭제
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
      final ToDoCard updatedToDo = editResults;
      setState(() {
        widget.ToDoList[index] = updatedToDo;
        widget.ToDoList.sort((a, b) => a.Date.compareTo(b.Date));
      });
      dbHelper.updateTodo(Todo( // 데이터베이스에서 할 일 업데이트
        id: widget.ToDoList[index].Id,
        title: widget.ToDoList[index].Title,
        date: widget.ToDoList[index].Date,
        durationTime: widget.ToDoList[index].DurationTime,
        memo: widget.ToDoList[index].Memo,
        isChecked: widget.ToDoList[index].isChecked,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var ToDoData = Provider.of<ToDoDataModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dbHelper.deletePastTodos();
    });

    return Scaffold(
      appBar: ToDoAppbar(),
      body: Container(
        color: PRIMARY_COLOR,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder<List<Todo>>(
            stream: dbHelper.todoStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('오늘은 어떤 일을 해볼까요?'));
              } else {
                final todos = snapshot.data!;
                widget.ToDoList.clear();
                widget.ToDoList.addAll(todos.map((todo) => ToDoCard(
                  Id: todo.id,
                  Title: todo.title,
                  Date: todo.date,
                  DurationTime: todo.durationTime,
                  Memo: todo.memo,
                  isChecked: todo.isChecked,
                  onChecked: (isChecked) => _handleToDoChecked(isChecked, widget.ToDoList.indexWhere((element) => element.Id == todo.id)),
                  onCancel: () => _ToDoDelete(widget.ToDoList.indexWhere((element) => element.Id == todo.id)),
                  onEdit: () => _ToDoEdit(widget.ToDoList.indexWhere((element) => element.Id == todo.id)),
                )));
                return ListView.builder(
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
                );
              }
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
            for (var todo in newToDoList) {
              dbHelper.insertTodo(Todo( // 데이터베이스에 새 할 일 추가
                id: todo.Id,
                title: todo.Title,
                date: todo.Date,
                durationTime: todo.DurationTime,
                memo: todo.Memo,
                isChecked: todo.isChecked,
              ));
            }
          }
        },
        child: Icon(Icons.add, color: TEXT_COLOR),
      ),
      bottomNavigationBar: MenuBottom(),
    );
  }

  void showCustomToast(BuildContext context, String message) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => customToast(message: message),
    );

    Overlay.of(context)!.insert(overlayEntry);

    // 일정 시간 후 토스트 알림을 제거합니다.
    Future.delayed(Duration(seconds: 2)).then((_) {
      overlayEntry.remove();
    });
  }

  // 랜덤 메시지를 표시하는 함수 추가
  void _showRandomToast() {
    final random = Random();
    final message = _congratulatoryMessages[random.nextInt(_congratulatoryMessages.length)];
    showCustomToast(context, message);
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
