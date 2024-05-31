import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/action/timerModel.dart';
import 'package:timer/action/timerSlide.dart';
import 'package:timer/screen/timerSetup.dart';
import 'package:timer/screen/login.dart';
import 'package:timer/action/selectedImageModel.dart';
import '../screen/to_do_list_screen.dart';
import '../model/todo_data_model.dart';
import '../action/nickNameProvider.dart';
import '../screen/welcome.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => TimerModel()),  // TimerModel을 Provider로 등록하여 전역 상태 관리
        ChangeNotifierProvider(create: (_) => SelectedImageModel()),  // SelectedImageModel을 Provider로 등록
        ChangeNotifierProvider(create: (_) => ToDoDataModel()),
        ChangeNotifierProvider(create: (_) => nickNameProvider()),
        ChangeNotifierProvider(create: (_) => TimerModel()),
      ],
      child: MyApp(),
    ),
  );
}

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        TimerModel();
        ToDoDataModel();
      },

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/todolist': (context) => ToDoScreen(),
          '/timerSetup': (context) => TimerSetup(),
          '/timerSlide': (context) => timerSlideExample(),
        },
      ),
    );
  }
}

 */

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        TimerModel();
        //ToDoDataModel();
      },

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/todolist': (context) => ToDoScreen(),
          '/timerSetup': (context) => TimerSetup(),
          '/timerSlide': (context) => timerSlideExample(),
          '/welcomeScreen': (context) => WelcomeScreen(),
        },
      ),
    );
  }
}