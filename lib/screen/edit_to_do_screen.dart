import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../widget/set_to_do_date.dart';
import '../widget/set_to_do_time.dart';
import 'package:provider/provider.dart';
import '../action/todo_data_model.dart';
import '../widget/to_do_card.dart';

class EditToDo extends StatefulWidget {
  ToDoCard todo;

  EditToDo({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  State<EditToDo> createState() => _setEditToDoState();
}

class _setEditToDoState extends State<EditToDo> {
  late TextEditingController titleController;
  late TextEditingController memoController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.Title);
    memoController = TextEditingController(text: widget.todo.Memo);
  }

  @override
  void dispose() {
    titleController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ToDoData = Provider.of<ToDoDataModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          '목표 수정',
          style: TextStyle(
            color: TEXT_COLOR,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: PRIMARY_COLOR,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AddToDoBody(
                      titleController: titleController,
                      memoController: memoController,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              color: PRIMARY_COLOR, // 저장 버튼 높이 설정
              child: TextButton(
                onPressed: () {
                  if (widget.todo.Title != titleController.text) widget.todo.Title = titleController.text;
                  if (widget.todo.Title != ToDoData.selectedDate) widget.todo.Date = ToDoData.selectedDate;
                  if (widget.todo.DurationTime != ToDoData.selectedDuration) widget.todo.DurationTime = ToDoData.selectedDuration;
                  if (widget.todo.Memo != memoController.text) widget.todo.Memo = memoController.text;
                  Navigator.pop(context, widget.todo); // 수정된 ToDoCard 객체 반환
                },
                style: TextButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '저장',
                  style: TextStyle(
                    color: TEXT_COLOR,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget AddToDoBody({
  required TextEditingController titleController,
  required TextEditingController memoController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      InputTitle(titleController: titleController),
      SizedBox(height: 2),
      SetDate(),
      SizedBox(height: 30),
      SetTime(),
      SizedBox(height: 30),
      InputMemo(memoController: memoController),
    ],
  );
}

class InputTitle extends StatelessWidget {
  final TextEditingController titleController;

  InputTitle({Key? key, required this.titleController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '목표',
            style: TextStyle(
              color: TEXT_COLOR,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 2.0),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Divider(
            thickness: 1.3,
            color: TEXT_COLOR,
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: titleController,
          maxLength: 20,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: '목표를 입력하세요',
            hintStyle: TextStyle(
              color: Color(0xFFB1B1B1),
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

class InputMemo extends StatelessWidget {
  final TextEditingController memoController;

  const InputMemo({Key? key, required this.memoController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '메모',
            style: TextStyle(
              color: TEXT_COLOR,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 2.0),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Divider(
            thickness: 1.3,
            color: TEXT_COLOR,
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: memoController,
          maxLength: 500,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: '메모를 입력하세요',
            hintStyle: TextStyle(
              color: Color(0xFFB1B1B1),
              fontSize: 16,
            ),
            contentPadding: EdgeInsets.only(bottom: 80, top: 20, left: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
