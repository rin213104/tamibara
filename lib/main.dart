import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/action/timerModel.dart';
import 'package:timer/action/timerSlide.dart';
import 'package:timer/screen/timerSetup.dart';
import 'package:timer/screen/login.dart';
import 'package:timer/action/selectedImageModel.dart';
import '../screen/to_do_list_screen.dart';
import 'action/todo_data_model.dart';
import '../action/nickNameProvider.dart';
import '../screen/welcome.dart';
import 'package:timer/action/gaming_data_model.dart';
import '../action/selected_todo_model.dart';
import '../database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isFirstRun = await checkFirstRun();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedImageModel()),
        ChangeNotifierProvider(create: (_) => ToDoDataModel()),
        ChangeNotifierProvider(create: (_) => nickNameProvider()),
        ChangeNotifierProvider(create: (_) => TimerModel()),
        ChangeNotifierProvider(create: (_) => GamingDataModel()),
        ChangeNotifierProvider(create: (_) => SelectedTodoModel()),
      ],
      child: MyApp(isFirstRun: isFirstRun),
    ),
  );
}

Future<bool> checkFirstRun() async {
  final dbHelper = DatabaseHelper();
  final isFirstRun = await dbHelper.getFirstRun();

  if (isFirstRun == null || isFirstRun == 1) {
    await dbHelper.insertFirstRun(0);
    return true;
  }
  return false;
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;
  const MyApp({required this.isFirstRun});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstRun ? '/' : '/todolist',
      routes: {
        '/': (context) => LoginScreen(),
        '/todolist': (context) => ToDoScreen(),
        '/timerSetup': (context) => TimerSetup(),
        '/timerSlide': (context) => timerSlideExample(),
        '/welcomeScreen': (context) => WelcomeScreen(selectedImage: 'assets/images/selected_image.png'),
      },
    );
  }
}