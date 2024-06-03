import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/todo_data_model.dart';
import '../const/colors.dart';

class SetDate extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  SetDate({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  State<SetDate> createState() => _SetDateState();
}

class _SetDateState extends State<SetDate> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoDataModel>(
      builder: (context, toDoData, _) {
        DateTime selectedDate = toDoData.selectedDate;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '날짜',
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
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return DateWheelPicker(
                        initialDate: selectedDate,
                        onDateSelected: (newDate) {
                          toDoData.setSelectedDate(newDate);
                          widget.onDateSelected(newDate); // 새로운 날짜를 전달
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
                        '${selectedDate.year}년',
                        style: TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 80.0),
                      Text(
                        '${selectedDate.month}월',
                        style: TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 80.0),
                      Text(
                        '${selectedDate.day}일',
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

class DateWheelPicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  DateWheelPicker({required this.initialDate, required this.onDateSelected});

  @override
  _DateWheelPickerState createState() => _DateWheelPickerState();
}

class _DateWheelPickerState extends State<DateWheelPicker> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  late List<int> years;
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> days = [];

  late ScrollController yearController;
  late ScrollController monthController;
  late ScrollController dayController;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDay = widget.initialDate.day;

    years = List.generate(10, (index) => selectedYear - 5 + index);
    _updateDays(selectedYear, selectedMonth);

    yearController = ScrollController(
      initialScrollOffset: years.indexOf(selectedYear) * 30.0,
    );
    monthController = ScrollController(
      initialScrollOffset: (selectedMonth - 1) * 30.0,
    );
    dayController = ScrollController(
      initialScrollOffset: (selectedDay - 1) * 30.0,
    );
  }

  void _updateDays(int year, int month) {
    days.clear();
    final daysInMonth = DateTime(year, month + 1, 0).day;
    setState(() {
      days = List.generate(daysInMonth, (index) => index + 1);
      if (selectedDay > daysInMonth) {
        selectedDay = daysInMonth;
      }
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (dayController.hasClients) {
          dayController.jumpTo((selectedDay - 1) * 30.0);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '목표 날짜',
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
                                    '년',
                                    style: TextStyle(
                                      height: 0.1,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 5,), // 텍스트와 휠스크롤 사이 간격
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: ListWheelScrollView(
                                controller: yearController,
                                overAndUnderCenterOpacity: 0.5,
                                useMagnifier: true,
                                itemExtent: 30,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    selectedYear = years[index];
                                    _updateDays(selectedYear, selectedMonth);
                                  });
                                },
                                children: years.map((e) => Text(e.toString())).toList(),
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
                                    '월',
                                    style: TextStyle(
                                      height: 0.1,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: ListWheelScrollView(
                                controller: monthController,
                                overAndUnderCenterOpacity: 0.5,
                                useMagnifier: true,
                                itemExtent: 30,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    selectedMonth = months[index];
                                    _updateDays(selectedYear, selectedMonth);
                                  });
                                },
                                children: months.map((e) => Text(e.toString())).toList(),
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
                                    '일',
                                    style: TextStyle(
                                      height: 0.1,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: ListWheelScrollView(
                                controller: dayController,
                                overAndUnderCenterOpacity: 0.5,
                                useMagnifier: true,
                                itemExtent: 30,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    selectedDay = days[index];
                                  });
                                },
                                children: days.map((e) => Text(e.toString())).toList(),
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
                      Navigator.pop(context); // 취소 버튼 클릭 시 팝업 닫기
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
                      final selectedYearIndex = (yearController.offset / 30).round();
                      final selectedMonthIndex = (monthController.offset / 30).round();
                      final selectedDayIndex = (dayController.offset / 30).round();
                      final newDate = DateTime(
                        years[selectedYearIndex],
                        months[selectedMonthIndex],
                        days[selectedDayIndex],
                      );
                      widget.onDateSelected(newDate);
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
