import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:tamibara/const/colors.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class setTime extends StatefulWidget {
  const setTime({Key? key}) : super(key: key);

  @override
  State<setTime> createState() => _setTimeState();
}

class _setTimeState extends State<setTime> {
  TimeOfDay initialTime = TimeOfDay.now();
  int hour = 0;
  int minute = 0;
  int second = 0;

  List<int> minutes = [];
  List<int> hours = [];
  List<int> seconds = [];

  List createList (List l, int x) { // create List hours, minutes, seconds
    for (int i=0; i<x; i++) {
      l.add(i);
    }
    return l;
  }
  Duration _duration = Duration(hours: 0, minutes: 0);

  @override
  Widget build(BuildContext context) {
    createList(hours,24);
    createList(minutes,60);
    createList(seconds,60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '목표 시간',
            style: TextStyle(
              color: Color(0xFF6F867C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        SizedBox(height: 2.0),

        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Divider(
            thickness: 1.3,
            color: Color(0xFF6F867C),
          ),
        ),

        SizedBox(height: 8.0),

        Expanded(
          //padding: EdgeInsets.only(),
          flex: 0,
          child: TextButton( // 클릭시 목표 시간 설정 창 띄움
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              await showDialog( // 목표 시간 설정 창 코드(시작)
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      //width: MediaQuery.of(context).size.width ,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        backgroundColor: Colors.white,

                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              //textAlign: TextAlign.left,
                              '목표 시간',
                              style: TextStyle(
                                color: Color(0xFF6F867C),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              thickness: 1.3,
                              color: Color(0xFF6F867C),
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
                                                SizedBox(height: 5,), // 텍스트와 휠스크롤 사이 간격
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 8,
                                            child: ListWheelScrollView( // wheelscroll
                                              overAndUnderCenterOpacity: 0.5, // 선택된 항목 제외 다른 항목 투명도
                                              useMagnifier: true, //확대경 사용 여부
                                              itemExtent: 30, // 아이템 크기
                                              onSelectedItemChanged: (i) {
                                                setState(() {
                                                  hour = hours[i];
                                                });
                                              },
                                              children: [
                                                ...hours.map(
                                                      (e) => Text(
                                                    e.toString(),
                                                  ),
                                                ),
                                              ],
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
                                                SizedBox(height: 5,),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 8,
                                            child: ListWheelScrollView(
                                              overAndUnderCenterOpacity: 0.5,
                                              useMagnifier: true,
                                              itemExtent: 30,
                                              onSelectedItemChanged: (i) {
                                                setState(() {
                                                  minute = minutes[i];
                                                });
                                              },
                                              children: [
                                                ...minutes.map(
                                                      (e) => Text(
                                                    e.toString(),
                                                  ),
                                                ),
                                              ],
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
                                                SizedBox(height: 5,),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 8,
                                            child: ListWheelScrollView(
                                              overAndUnderCenterOpacity: 0.5,
                                              useMagnifier: true,
                                              itemExtent: 30,
                                              onSelectedItemChanged: (i) {
                                                setState(() {
                                                  second = seconds[i];
                                                });
                                              },
                                              children: [
                                                ...seconds.map(
                                                      (e) => Text(
                                                    e.toString(),
                                                  ),
                                                ),
                                              ],
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
                                //height: 33.0,
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
                                //height: 16.0,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    // 확인 버튼 클릭 시 원하는 작업 수행
                                    Navigator.pop(context); // 팝업 닫기
                                  },
                                  child: Text(
                                    '확인',
                                    style: TextStyle(
                                      color: Color(0xFF6F867C),
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




                },
              ); // // 목표 시간 설정 창 코드(끝)






            },


            child: Padding( // 텍스트 버튼 글자 ' 년 월 일'
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
  }
}


