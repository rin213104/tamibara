import 'package:flutter/material.dart';
import '../widget/to_do_card.dart';
import '../const/colors.dart';
import '../screen/add_to_do_screen.dart';
import '../screen/edit_to_do_screen.dart';
import '../shared/menu_bottom.dart';
import 'package:provider/provider.dart';
import '../model/todo_data_model.dart';

class ToDoScreen extends StatefulWidget { //투두 리스트 화면
  final List<ToDoCard> ToDoList = [];

  ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _setToDoScreenState();
}

class _setToDoScreenState extends State<ToDoScreen> {
  void _handleToDoChecked(bool isChecked, int index) {  //
    if (isChecked) {
      setState(() {
        widget.ToDoList.removeAt(index);
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
