import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/action/timerModel.dart';
import 'package:timer/action/timerSlide.dart';
import 'package:timer/screen/timerSetup.dart';
import 'package:timer/screen/goal.dart';
import 'package:timer/screen/login.dart';
import 'package:timer/action/selectedImageModel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => TimerModel()),  // TimerModel을 Provider로 등록하여 전역 상태 관리
        ChangeNotifierProvider(create: (_) => SelectedImageModel()),  // SelectedImageModel을 Provider로 등록
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/goal': (context) => GoalPage(),
          '/timerSetup': (context) => TimerSetup(),
          '/timerSlide': (context) => timerSlideExample(),
        },
      ),
    );
  }
}