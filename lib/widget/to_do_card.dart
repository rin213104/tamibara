import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../model/todo_data_model.dart';
import 'package:provider/provider.dart';

class ToDoCard extends StatefulWidget {
  final String id;
  final String title;
  final DateTime date;
  final int durationTime;
  final String memo;
  bool isChecked;
  final ValueChanged<bool> onChecked;
  final VoidCallback onCancel;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  ToDoCard({
    required this.id,
    required this.title,
    required this.date,
    required this.durationTime,
    required this.memo,
    this.isChecked = false,
    required this.onChecked,
    required this.onCancel,
    required this.onEdit,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  late bool isChecked;

  String formatted(int x) {
    return x.toString().padLeft(2, "0");
  }

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    var ToDoData = Provider.of<ToDoDataModel>(context);

    int second = widget.durationTime;
    int hour = second ~/ 3600;
    second %= 3600;
    int minute = second ~/ 60;
    second %= 60;

    return Container( // To-do-list 내용이 담긴 카드
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 70,
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: Checkbox(
                value: isChecked,
                activeColor: TEXT_COLOR,
                checkColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                  widget.onChecked(isChecked);
                },
              ),
            ),
            Flexible(
              flex: 6,
              child: Container(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( // title
                      widget.title,
                      style: TextStyle(
                        fontSize: 19,
                        color: Color(0xFF393939),
                      ),
                    ),
                    Text( //duration
                      "${formatted(hour)}:${formatted(minute)}:${formatted(second)}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4D6058),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton( //view memo
                padding: EdgeInsets.zero, // 패딩 설정
                constraints: BoxConstraints(), // constraints
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(widget.title),
                        content: widget.memo.isNotEmpty
                            ? Text(widget.memo)
                            : Text(""),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Navigator.pop(context); // 버튼 클릭 시 팝업 닫기
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: TEXT_COLOR,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.info_outline,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton( //edit
                padding: EdgeInsets.zero, // 패딩 설정
                constraints: BoxConstraints(),
                onPressed: () {
                  widget.onEdit();
                },
                icon: Icon(
                  Icons.edit_outlined,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton( //delete
                padding: EdgeInsets.zero, // 패딩 설정
                constraints: BoxConstraints(),
                onPressed: () {
                  // 삭제 여부 묻는 다이얼로그 + 카드 삭제 함수
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        content: Text(
                          "정말로 삭제하시겠습니까?",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        actions: <Widget>[
                          ButtonBar(
                            buttonPadding: EdgeInsets.symmetric(horizontal: 0),
                            children: [
                              SizedBox(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '취소',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              SizedBox(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    widget.onCancel();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '확인',
                                    style: TextStyle(
                                      color: TEXT_COLOR,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.cancel_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
