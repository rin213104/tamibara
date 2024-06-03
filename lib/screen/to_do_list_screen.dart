import 'package:flutter/material.dart';
import '../widget/to_do_card.dart';
import '../const/colors.dart';
import '../screen/add_to_do_screen.dart';
import '../screen/edit_to_do_screen.dart';
import '../shared/menu_bottom.dart';
import 'package:provider/provider.dart';
import '../model/todo_data_model.dart';
import '../screen/timerAnalog.dart';
import '../database/database_helper.dart';
import '../model/todo.dart';

class ToDoScreen extends StatefulWidget {
  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  late DatabaseHelper dbHelper;
  List<ToDo> toDoList = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    _loadToDoList();
  }

  Future<void> _loadToDoList() async {
    final data = await dbHelper.getToDos();
    setState(() {
      toDoList = data;
    });
  }

  void _handleToDoChecked(bool isChecked, int index) {
    setState(() {
      toDoList[index].isChecked = isChecked;
    });
    if (isChecked) {
      _deleteToDoItem(index);
    } else {
      dbHelper.updateToDo(toDoList[index]);
    }
  }

  Future<void> _deleteToDoItem(int index) async {
    await dbHelper.deleteToDo(toDoList[index].id);
    setState(() {
      toDoList.removeAt(index);
    });
  }

  Future<void> _editToDoItem(int index) async {
    final editedToDo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditToDo(
        todo: ToDo(
          id: toDoList[index].id,
          title: toDoList[index].title,
          date: toDoList[index].date,
          duration: toDoList[index].duration,
          memo: toDoList[index].memo,
          isChecked: toDoList[index].isChecked,
        ),
      )),
    );

    if (editedToDo != null) {
      await dbHelper.updateToDo(editedToDo);
      _loadToDoList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: PRIMARY_COLOR,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: toDoList.isEmpty
              ? Center(child: Text('No ToDo items', style: TextStyle(color: TEXT_COLOR)))
              : ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              bool showDateDivider = index == 0 ||
                  toDoList[index].date != toDoList[index - 1].date;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showDateDivider) ...[
                    SizedBox(height: 10),
                    Text(
                      '${toDoList[index].date.year}.${toDoList[index].date.month}.${toDoList[index].date.day}',
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
                    id: toDoList[index].id,
                    title: toDoList[index].title,
                    date: toDoList[index].date,
                    durationTime: toDoList[index].duration,
                    memo: toDoList[index].memo,
                    isChecked: toDoList[index].isChecked,
                    onChecked: (isChecked) => _handleToDoChecked(isChecked, index),
                    onCancel: () => _deleteToDoItem(index),
                    onEdit: () => _editToDoItem(index),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerAnalogPage(duration: toDoList[index].duration),
                        ),
                      );
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
          final newToDo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddToDo()),
          );

          if (newToDo != null) {
            await dbHelper.insertToDo(newToDo);
            _loadToDoList();
          }
        },
        child: Icon(Icons.add, color: TEXT_COLOR),
      ),
      bottomNavigationBar: MenuBottom(),
    );
  }

  AppBar _buildAppBar() {
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
}
