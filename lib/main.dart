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
        ChangeNotifierProvider(create: (_) => SelectedImageModel()),
        ChangeNotifierProvider(create: (_) => ToDoDataModel()),
        ChangeNotifierProvider(create: (_) => nickNameProvider()),
        ChangeNotifierProvider(create: (_) => TimerModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/todolist': (context) => ToDoScreen(),
        '/timerSetup': (context) => TimerSetup(),
        '/timerSlide': (context) => TimerSlideExample(duration: 600), // 기본 duration 값 설정 (예: 10분)
        '/welcomeScreen': (context) => WelcomeScreen(selectedImage: 'assets/images/selected_image.png'),
      },
    );
  }
}
