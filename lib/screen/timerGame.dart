import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../shared/menu_bottom.dart';
import '../action/timerModel.dart'; // TimerModel 경로 확인
import '../action/selectedImageModel.dart';
import '../const/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerModel()),
        ChangeNotifierProvider(create: (_) => SelectedImageModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TimerGamePage(), // 기본 이미지 경로 설정
      ),
    );
  }
}

class TimerGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Column(
        children: [
          buildTopBar(context),
          Expanded(
            child: Center(
              child: Text(
                'Timer Game Content',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuBottom(),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: MediaQuery.of(context).size.height / 8,
      alignment: Alignment.center,
      color: PRIMARY_COLOR,
      child: buildDateText(),
    );
  }

  Widget buildDateText() {
    final now = DateTime.now();
    final formattedDate = DateFormat('MM.dd.EEE').format(now);

    return Text(
      formattedDate,
      style: TextStyle(
        color: TIMER_COLOR,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}