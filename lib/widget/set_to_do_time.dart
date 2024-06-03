import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/todo_data_model.dart';
import '../const/colors.dart';

class SetTime extends StatefulWidget {
  final ValueChanged<Duration> onDurationSelected;

  SetTime({Key? key, required this.onDurationSelected}) : super(key: key);

  @override
  State<SetTime> createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoDataModel>(
      builder: (context, toDoData, _) {
        int selectedDuration = toDoData.selectedDuration;
        int second = selectedDuration;
        int hour = second ~/ 3600;
        second %= 3600;
        int minute = second ~/ 60;
        second %= 60;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '목표 시간',
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
            Expanded(
              flex: 0,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog<Duration>(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return TimeWheelPicker(
                        initialTime: Duration(hours: hour, minutes: minute, seconds: second),
                        onDurationSelected: (newData) {
                          toDoData.setSelectedDuration(newData.inSeconds);
                          widget.onDurationSelected(newData); // 새로운 시간을 전달
                        },
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${hour}시간',
                        style: TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 80.0),
                      Text(
                        '${minute}분',
                        style: TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 80.0),
                      Text(
                        '${second}초',
                        style: TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TimeWheelPicker extends StatefulWidget {
  final Duration initialTime;
  final ValueChanged<Duration> onDurationSelected;

  TimeWheelPicker({
    required this.initialTime,
    required this.onDurationSelected,
  });

  @override
  _TimeWheelPickerState createState() => _TimeWheelPickerState();
}

class _TimeWheelPickerState extends State<TimeWheelPicker> {
  late int hour;
  late int minute;
  late int second;

  @override
  void initState() {
    super.initState();
    hour = widget.initialTime.inHours;
    minute = widget.initialTime.inMinutes % 60;
    second = widget.initialTime.inSeconds % 60;
  }

  List<int> _createList(int length) {
    return List<int>.generate(length, (index) => index);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '목표 시간',
                style: TextStyle(
                  color: TEXT_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Divider(
                thickness: 1.3,
                color: TEXT_COLOR,
              ),
            ],
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Column(
                                children: [
                                  Text(
                                    '시간',
                                    style: TextStyle(
                                      height: 0.1,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: ListWheelScrollView.useDelegate(
                                controller: FixedExtentScrollController(initialItem: hour),
                                overAndUnderCenterOpacity: 0.5,
                                useMagnifier: true,
                                itemExtent: 30,
                                onSelectedItemChanged: (i) {
                                  setState(() {
                                    hour = i;
                                  });
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    return Text(index.toString());
                                  },
                                  childCount: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Column(
                                children: [
                                  Text(
                                    '분',
                                    style: TextStyle(
                                      height: 0.1,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: ListWheelScrollView.useDelegate(
                                controller: FixedExtentScrollController(initialItem: minute),
                                overAndUnderCenterOpacity: 0.5,
                                useMagnifier: true,
                                itemExtent: 30,
                                onSelectedItemChanged: (i) {
                                  setState(() {
                                    minute = i;
                                  });
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    return Text(index.toString());
                                  },
                                  childCount: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Column(
                                children: [
                                  Text(
                                    '초',
                                    style: TextStyle(
                                      height: 0.1,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: ListWheelScrollView.useDelegate(
                                controller: FixedExtentScrollController(initialItem: second),
                                overAndUnderCenterOpacity: 0.5,
                                useMagnifier: true,
                                itemExtent: 30,
                                onSelectedItemChanged: (i) {
                                  setState(() {
                                    second = i;
                                  });
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    return Text(index.toString());
                                  },
                                  childCount: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                      final newData = Duration(hours: hour, minutes: minute, seconds: second);
                      widget.onDurationSelected(newData);
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
        ),
      ),
    );
  }
}
