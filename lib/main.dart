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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/welcomeScreen') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return WelcomeScreen(selectedImage: args);
            },
          );
        }
        // 기본 라우트 처리
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/todolist':
            return MaterialPageRoute(builder: (context) => ToDoScreen());
          case '/timerSetup':
            return MaterialPageRoute(builder: (context) => TimerSetup());
          case '/timerSlide':
            return MaterialPageRoute(builder: (context) => timerSlideExample());
          default:
            return null;
        }
      },
    );
  }
}