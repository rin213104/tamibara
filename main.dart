import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'action/timerModel.dart';
import 'action/timerSlide.dart';
import 'screen/timerSetup.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TimerModel(),  // TimerModel을 Provider로 등록하여 전역 상태 관리
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TimerSetup(),  // 타이머 설정 화면을 초기 화면으로 설정
        '/slide': (context) => PageSlideExample(),  // timerSlide 화면으로 이동
      },
    );
  }
}